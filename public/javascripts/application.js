// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/* setup event handlers for the links in the login/signup nav */
function setupLognNav() {
  $("#login-link").click(function(event) {
    toggleLoginForm();
    event.preventDefault();
  });
  
  $("#cancel-button-direct").click(function(event) {
    toggleLoginForm();
    event.preventDefault();
  });

  $("#cancel-button-openid").click(function(event) {
    toggleLoginForm();
    event.preventDefault();
  });

  
  $("#login-again-link").click(function(event) {
    $("#login-form").show();
    $("#login-links").hide();
    $("#login-again").hide();
    event.preventDefault();
  });
  
  $("#switch-login-openid").click(function(event) {
    switchLogin();
    event.preventDefault();
  });

  $("#switch-login-direct").click(function(event) {
    switchLogin();
    event.preventDefault();
  });
}

/* show the form to give the user a chance to login again */
function showLoginAgain() {
  $("#login-again").show();
  $("#login-links").hide();
  $("#login-form").hide();
}

function switchLogin() {
  $("#direct-login").toggle();
  $("#openid-login").toggle();
}

function toggleLoginForm() {
  $("#login-links").toggle();
  $("#login-form").toggle();
}

/* setup event handler for the flash notice div */
function setupNotice() {
  $("#close-notice").click(function () {
    $("#notice").fadeOut("slow");
  });
}

