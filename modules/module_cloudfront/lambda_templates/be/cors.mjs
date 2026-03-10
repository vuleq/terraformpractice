'use strict';

export const handler = async (event, context, callback) => {
    // TERRAFORM_REPLACE_START:CORS_ORIGINS
    const ALLOWED_ORIGINS = [
        'https://dkq832w8boiiy.cloudfront.net',
        'https://dnbehzxeiaxff.cloudfront.net',
        'http://localhost:4200',
        'http://localhost:8100',
        'http://localhost:8101',
        'http://localhost:*',
        'http://127.0.0.1:*',
        'https://fe-devtest.s3.ap-southeast-1.amazonaws.com',
        'https://fe-devtest.s3.amazonaws.com',
        'https://ksl-wdr-s3-dev.s3.ap-southeast-1.amazonaws.com',
        'https://ksl-wdr-s3-dev.s3.amazonaws.com',
        'http://fe-devtest.s3-website-ap-southeast-1.amazonaws.com',
        'http://ksl-wdr-s3-dev.s3-website-ap-southeast-1.amazonaws.com'
    ];
    // TERRAFORM_REPLACE_END:CORS_ORIGINS
    
    const cf = event.Records[0].cf;
    const request = cf.request;
    const response = cf.response;
    const headers = response.headers;
    
    const requestOrigin = request.headers.origin ? request.headers.origin[0].value : undefined;
    
    const isOriginAllowed = (origin) => {
        if (!origin) return false;
        
        if (ALLOWED_ORIGINS.includes(origin)) {
            return true;
        }
        
        return ALLOWED_ORIGINS.some(allowedOrigin => {
            if (allowedOrigin.includes('*')) {
                // Convert wildcard pattern to regex
                // http://localhost:* -> http://localhost:\d+
                // https://*.googleapis.com -> https://.*\.googleapis\.com
                const pattern = allowedOrigin
                    .replace(/\./g, '\\.')
                    .replace(/\*/g, allowedOrigin.includes('localhost:*') ? '\\d+' : '[^.]+');
                const regex = new RegExp(`^${pattern}$`);
                return regex.test(origin);
            }
            return false;
        });
    };
    
    if (requestOrigin && isOriginAllowed(requestOrigin)) {
        headers['access-control-allow-origin'] = [{
            key: 'Access-Control-Allow-Origin',
            value: requestOrigin
        }];
        headers['vary'] = [{
            key: 'Vary',
            value: 'Origin'
        }];
        headers['access-control-allow-methods'] = [{
            key: 'Access-Control-Allow-Methods',
            value: 'GET, HEAD, OPTIONS, POST, PUT, DELETE, PATCH'
        }];
        headers['access-control-allow-headers'] = [{
            key: 'Access-Control-Allow-Headers',
            value: 'Content-Type,Authorization'
        }];
        headers['access-control-allow-credentials'] = [{
           key: 'Access-Control-Allow-Credentials',
           value: 'true'
        }];
        console.log(`CORS allowed for origin: ${requestOrigin}`);
    } else {
        delete headers['access-control-allow-origin'];
        delete headers['access-control-allow-credentials'];
        if (requestOrigin) {
            console.log(`CORS denied for origin: ${requestOrigin}`);
        }
    }
    
    callback(null, response);
};