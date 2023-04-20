class CookieBar {
  constructor() {
    this.cookiesBar = document.getElementById('cookies-bar');
  }

  init() {
    this.cookiesAllowed();
    this.addButtonBehaviors();
  }

  cookiesAllowed() {
    return Cookies.get('allow_cookies') === 'yes';
  }

  addButtonBehaviors() {
    if (!this.cookiesBar) {
      return;
    }

    this.cookiesBar.querySelector('.accept').addEventListener('click', () => this.allowCookies(true));

    this.cookiesBar.querySelector('.reject').addEventListener('click', () => this.allowCookies(false));
  }

  allowCookies(allow) {
    if (allow) {
      Cookies.set('allow_cookies', 'yes', {
        expires: 365
      });
    } else {
      Cookies.set('allow_cookies', 'no', {
        expires: 365
      });
    }

    this.cookiesBar.classList.add('hidden');
  }
}

window.onload = function() {
  const cookieBar = new CookieBar();

  cookieBar.init();
}