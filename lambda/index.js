exports.handler = async (event) => {
  console.log('Event:', JSON.stringify(event, null, 2));

  return {
    statusCode: 200,
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      message: 'Hello from Lambda!',
      path: event.rawPath || '/',
      method: event.requestContext?.http?.method || 'UNKNOWN',
      timestamp: new Date().toISOString(),
    }),
  };
};
