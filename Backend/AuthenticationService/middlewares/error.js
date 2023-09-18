const generalErrorMessage = {
    error: "",
    message: ""
}

const statusCodeToErrorTitle = {
    400: "Bad Request Error",
    404: "Missing Resource"
}

const sendErrorResponse = (res, status, errorMessage) => {
    setErrorMessage(errorMessage,status)
    return res.status(status).json(generalErrorMessage);
  };

const setErrorMessage = (errorMessage,status) => {
    generalErrorMessage.message = errorMessage
    generalErrorMessage.error = statusCodeToErrorTitle[status]
}

module.exports = sendErrorResponse