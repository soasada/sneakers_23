const dom = {};

function getProductIds() {
  const products = document.querySelectorAll('.product-listing');
  return Array.from(products).map((el) => el.dataset.productId);
}

dom.getProductIds = getProductIds;

export default dom;
