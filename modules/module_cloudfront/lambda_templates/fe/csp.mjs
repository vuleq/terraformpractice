'use strict';
import { S3Client, GetObjectCommand } from '@aws-sdk/client-s3';
import { randomBytes } from 'crypto';

// TERRAFORM_REPLACE_START:CSP_CONFIG
const CONFIG = {
    S3_BUCKET_NAME: 'fe-devtest',
    S3_REGION: 'ap-southeast-1',
    API_CLOUDFRONT_DOMAIN: 'doenn2kkpkvek.cloudfront.net',
    COGNITO_REGION: 'ap-southeast-1',
    COGNITO_USER_POOL_ID: 'ap-southeast-141oipcg4h',
    S3_ASSETS_BUCKET: 'ksl-wdr-s3-dev',
    ADDITIONAL_CONNECT_SRC: '',
    ADDITIONAL_IMG_SRC: ''
};
// TERRAFORM_REPLACE_END:CSP_CONFIG

const s3Client = new S3Client({ region: CONFIG.S3_REGION });

const generateNonce = () => randomBytes(16).toString('base64');

const streamToString = (stream) => new Promise((resolve, reject) => {
    const chunks = [];
    stream.on("data", (chunk) => chunks.push(chunk));
    stream.on("error", reject);
    stream.on("end", () => resolve(Buffer.concat(chunks).toString("utf8")));
});

export const handler = async (event) => {
    const response = event.Records[0].cf.response;
    const request = event.Records[0].cf.request;
    const headers = response.headers;
    const objectKey = request.uri.substring(1) || 'index.html';

    // ========================================
    // ADD CORS HEADERS FOR ALL RESPONSE
    // ========================================
    headers['access-control-allow-origin'] = [{
        key: 'Access-Control-Allow-Origin',
        value: '*'
    }];
    
    headers['access-control-allow-methods'] = [{
        key: 'Access-Control-Allow-Methods',
        value: 'GET, HEAD, OPTIONS'
    }];
    
    headers['access-control-allow-headers'] = [{
        key: 'Access-Control-Allow-Headers',
        value: '*'
    }];

    headers['access-control-expose-headers'] = [{
        key: 'Access-Control-Expose-Headers',
        value: 'ETag'
    }];

    // ========================================
    // add for INDEX.HTML
    // ========================================
    if (objectKey.endsWith('index.html') || request.uri === '/') {
        try {
            const nonce = generateNonce();

            const connectSrcDomains = [
                `https://${CONFIG.API_CLOUDFRONT_DOMAIN}`,
                `https://cognito-idp.${CONFIG.COGNITO_REGION}.amazonaws.com`,
                `https://${CONFIG.COGNITO_USER_POOL_ID}.auth.${CONFIG.COGNITO_REGION}.amazoncognito.com`,
                `https://cognito-identity.${CONFIG.COGNITO_REGION}.amazonaws.com`,
                `https://${CONFIG.S3_ASSETS_BUCKET}.s3.${CONFIG.S3_REGION}.amazonaws.com`,
                'https://*.googleapis.com',
                `wss://*.execute-api.${CONFIG.S3_REGION}.amazonaws.com`,
                // Add localhost for mobile development
                'http://localhost:*',
                'http://127.0.0.1:*'
            ];

            if (CONFIG.ADDITIONAL_CONNECT_SRC) {
                const additionalDomains = CONFIG.ADDITIONAL_CONNECT_SRC
                    .split(',').map(d => d.trim()).filter(d => d.length > 0);
                connectSrcDomains.push(...additionalDomains);
            }

            const imgSrcDomains = [
                `https://${CONFIG.S3_ASSETS_BUCKET}.s3.${CONFIG.S3_REGION}.amazonaws.com`
            ];

            if (CONFIG.ADDITIONAL_IMG_SRC) {
                const additionalImgDomains = CONFIG.ADDITIONAL_IMG_SRC
                    .split(',').map(d => d.trim()).filter(d => d.length > 0);
                imgSrcDomains.push(...additionalImgDomains);
            }

            const cspValue = [
                "default-src 'none'",
                `script-src 'self' 'nonce-${nonce}'`,
                "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com",
                "object-src 'none'",
                "base-uri 'self'",
                `connect-src 'self' ${connectSrcDomains.join(' ')}`,
                `img-src 'self' data: blob: ${imgSrcDomains.join(' ')}`,
                "manifest-src 'self'",
                "font-src 'self' https://fonts.googleapis.com https://fonts.gstatic.com",
                "frame-ancestors 'none'",
                "form-action 'self'"
            ].join('; ');

            headers['content-security-policy'] = [{
                key: 'Content-Security-Policy',
                value: cspValue
            }];

            const s3Object = await s3Client.send(new GetObjectCommand({
                Bucket: CONFIG.S3_BUCKET_NAME,
                Key: 'index.html'
            }));
            let htmlBody = await streamToString(s3Object.Body);

            htmlBody = htmlBody.replace(
                '</head>',
                `<script>globalThis.myRandomNonceValue = '${nonce}';</script>\n</head>`
            );
            htmlBody = htmlBody.replace(/<script/g, `<script nonce="${nonce}"`);

            response.body = htmlBody;
            response.bodyEncoding = 'text';

            headers['cache-control'] = [{
                key: 'Cache-Control',
                value: 'no-cache, no-store, must-revalidate'
            }];

            console.log(`CSP applied with nonce for ${objectKey}`);
        } catch (error) {
            console.error("Lambda@Edge Error:", error);
        }
    }

    return response;
};