
  class BadRequestError extends Error {
    constructor(message) {
      super(message);
      this.name = 'BadRequestError';
      this.statusCode = 400;
    }
  }
  
  class NotFoundError extends Error {
    constructor(message) {
      super(message);
      this.name = 'NotFoundError';
      this.statusCode = 404;
    }
  }
  
  // You can create more custom error classes as needed
  
const customError = {
    BadRequestError, NotFoundError
}

module.exports = customError