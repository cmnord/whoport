// Live-update half of tools/man-preview.
//
// Polls the rendered page and swaps <body> when it changes.  Swapping rather
// than reloading means no navigation, so the browser shows no spinner, no tab
// throbber, and no flash of blank page.
//
// This script is loaded from <head>, which is never replaced, so the polling
// loop survives every update.

(() => {
  const INTERVAL_MS = 400;
  let last = null;

  const poll = async () => {
    try {
      const res = await fetch('index.html', { cache: 'no-store' });
      const text = await res.text();

      // skip the first pass: that content is already on screen
      if (last !== null && text !== last) {
        const doc = new DOMParser().parseFromString(text, 'text/html');
        const y = window.scrollY;
        document.body.replaceWith(doc.body);
        window.scrollTo(0, y);
      }
      last = text;
    } catch (e) {
      // server not up yet, or a render in flight -- just try again next tick
    }
    setTimeout(poll, INTERVAL_MS);
  };

  poll();
})();
