import "../css/app.css"
import "phoenix_html"
import {productSocket} from './product_socket';
import dom from './dom';

const productIds = dom.getProductIds();

if (productIds.length > 0) {
  productSocket.connect();
  productIds.forEach((id) => setupProductChannel(productSocket, id));
}

function setupProductChannel(socket, productId) {
  const productChannel = socket.channel(`product:${productId}`);
  productChannel.join()
    .receive("error", () => console.error("Channel join failed"));
  productChannel.on("released", ({size_html}) => dom.replaceProductComingSoon(productId, size_html));
}
