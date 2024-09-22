import ballerina/io;

ShoppingServiceClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    AddProductRequest addProductRequest = {product: {name: "ballerina", description: "ballerina", price: 1, stock_quantity: 1, sku: "ballerina", status: "available"}};
    ProductCodeResponse addProductResponse = check ep->AddProduct(addProductRequest);
    io:println(addProductResponse);

    UpdateProductRequest updateProductRequest = {sku: "ballerina", product: {name: "ballerina", description: "ballerina", price: 1, stock_quantity: 1, sku: "ballerina", status: "ballerina"}};
    ProductCodeResponse updateProductResponse = check ep->UpdateProduct(updateProductRequest);
    io:println(updateProductResponse);

    RemoveProductRequest removeProductRequest = {sku: "ballerina"};
    ProductListResponse removeProductResponse = check ep->RemoveProduct(removeProductRequest);
    io:println(removeProductResponse);

    ProductListResponse listAvailableProductsResponse = check ep->ListAvailableProducts();
    io:println(listAvailableProductsResponse);

    SearchProductRequest searchProductRequest = {sku: "ballerina"};
    SearchProductResponse searchProductResponse = check ep->SearchProduct(searchProductRequest);
    io:println(searchProductResponse);

    AddToCartRequest addToCartRequest = {user_id: "ballerina", sku: "ballerina"};
    check ep->AddToCart(addToCartRequest);

    PlaceOrderRequest placeOrderRequest = {user_id: "ballerina"};
    check ep->PlaceOrder(placeOrderRequest);

    CreateUsersRequest createUsersRequest = {user: {user_id: "ballerina", role: "ballerina"}};
    CreateUsersStreamingClient createUsersStreamingClient = check ep->CreateUsers();
    check createUsersStreamingClient->sendCreateUsersRequest(createUsersRequest);
    check createUsersStreamingClient->complete();
    CreateUsersResponse? createUsersResponse = check createUsersStreamingClient->receiveCreateUsersResponse();
    io:println(createUsersResponse);
}

