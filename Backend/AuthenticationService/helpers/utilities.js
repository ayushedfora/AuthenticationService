const isValidEmail = (email) => {
    const emailPattern = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    return emailPattern.test(email);
  };

const isValidPassword = (password) => {
    return password.length > 6
}

const isValidMobileNumber = (mobileNo) => {
    const phoneNumberPattern = /^(\+\d{1,3}[- ]?)?\d{10}$/
    return phoneNumberPattern.test(mobileNo)
}

const utilityFunctions = {
    isValidEmail,
    isValidPassword,
    isValidMobileNumber
}

module.exports = utilityFunctions