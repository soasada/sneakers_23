const dom = {};

function removeStockLevelClasses(el) {
  Array.from(el.classList)
    .filter(s => s.startsWith('size-container__entry--level-'))
    .forEach(name => el.classList.remove(name));
}

function getProductIds() {
  const products = document.querySelectorAll('.product-listing');
  return Array.from(products).map((el) => el.dataset.productId);
}

function replaceProductComingSoon(productId, size_html) {
  const name = `.product-soon-${productId}`;
  const productSoonEls = document.querySelectorAll(name);
  productSoonEls.forEach((el) => {
    const fragment = document.createRange().createContextualFragment(size_html);
    el.replaceWith(fragment);
  });
}

function updateItemLevel(itemId, level) {
  Array.from(document.querySelectorAll('.size-container__entry'))
    .filter(el => el.value == itemId)
    .forEach(el => {
      removeStockLevelClasses(el);
      el.classList.add(`size-container__entry--level-${level}`);
      el.disabled = level == 'out';
    });
}

dom.getProductIds = getProductIds;
dom.replaceProductComingSoon = replaceProductComingSoon;
dom.updateItemLevel = updateItemLevel;

export default dom;
