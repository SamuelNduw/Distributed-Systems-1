import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;

public const string ONLINESHOPPING_DESC = "0A146F6E6C696E6553686F7070696E672E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22A6010A0750726F6475637412120A046E616D6518012001280952046E616D6512200A0B6465736372697074696F6E180220012809520B6465736372697074696F6E12140A0570726963651803200128025205707269636512250A0E73746F636B5F7175616E74697479180420012805520D73746F636B5175616E7469747912100A03736B751805200128095203736B7512160A06737461747573180620012809520673746174757322460A054F7264657212170A07757365725F6964180120012809520675736572496412240A0870726F647563747318022003280B32082E50726F64756374520870726F647563747322330A045573657212170A07757365725F6964180120012809520675736572496412120A04726F6C651802200128095204726F6C6522370A1141646450726F647563745265717565737412220A0770726F6475637418012001280B32082E50726F64756374520770726F6475637422380A1350726F64756374436F6465526573706F6E736512210A0C70726F647563745F636F6465180120012809520B70726F64756374436F6465224C0A1455706461746550726F647563745265717565737412100A03736B751801200128095203736B7512220A0770726F6475637418022001280B32082E50726F64756374520770726F6475637422280A1452656D6F766550726F647563745265717565737412100A03736B751801200128095203736B75223B0A1350726F647563744C697374526573706F6E736512240A0870726F647563747318012003280B32082E50726F64756374520870726F647563747322280A1453656172636850726F647563745265717565737412100A03736B751801200128095203736B75223B0A1553656172636850726F64756374526573706F6E736512220A0770726F6475637418012001280B32082E50726F64756374520770726F64756374223D0A10416464546F436172745265717565737412170A07757365725F6964180120012809520675736572496412100A03736B751802200128095203736B75222C0A11506C6163654F726465725265717565737412170A07757365725F69641801200128095206757365724964222F0A1243726561746555736572735265717565737412190A047573657218012001280B32052E55736572520475736572222D0A134372656174655573657273526573706F6E736512160A06737461747573180120012809520673746174757332FA030A0F53686F7070696E675365727669636512360A0A41646450726F6475637412122E41646450726F64756374526571756573741A142E50726F64756374436F6465526573706F6E7365123C0A0D55706461746550726F6475637412152E55706461746550726F64756374526571756573741A142E50726F64756374436F6465526573706F6E7365123C0A0D52656D6F766550726F6475637412152E52656D6F766550726F64756374526571756573741A142E50726F647563744C697374526573706F6E7365123A0A0B437265617465557365727312132E4372656174655573657273526571756573741A142E4372656174655573657273526573706F6E7365280112450A154C697374417661696C61626C6550726F647563747312162E676F6F676C652E70726F746F6275662E456D7074791A142E50726F647563744C697374526573706F6E7365123E0A0D53656172636850726F6475637412152E53656172636850726F64756374526571756573741A162E53656172636850726F64756374526573706F6E736512360A09416464546F4361727412112E416464546F43617274526571756573741A162E676F6F676C652E70726F746F6275662E456D70747912380A0A506C6163654F7264657212122E506C6163654F72646572526571756573741A162E676F6F676C652E70726F746F6275662E456D707479620670726F746F33";

public isolated client class ShoppingServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, ONLINESHOPPING_DESC);
    }

    isolated remote function AddProduct(AddProductRequest|ContextAddProductRequest req) returns ProductCodeResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddProductRequest message;
        if req is ContextAddProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/AddProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductCodeResponse>result;
    }

    isolated remote function AddProductContext(AddProductRequest|ContextAddProductRequest req) returns ContextProductCodeResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddProductRequest message;
        if req is ContextAddProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/AddProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductCodeResponse>result, headers: respHeaders};
    }

    isolated remote function UpdateProduct(UpdateProductRequest|ContextUpdateProductRequest req) returns ProductCodeResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateProductRequest message;
        if req is ContextUpdateProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/UpdateProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductCodeResponse>result;
    }

    isolated remote function UpdateProductContext(UpdateProductRequest|ContextUpdateProductRequest req) returns ContextProductCodeResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateProductRequest message;
        if req is ContextUpdateProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/UpdateProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductCodeResponse>result, headers: respHeaders};
    }

    isolated remote function RemoveProduct(RemoveProductRequest|ContextRemoveProductRequest req) returns ProductListResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveProductRequest message;
        if req is ContextRemoveProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/RemoveProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductListResponse>result;
    }

    isolated remote function RemoveProductContext(RemoveProductRequest|ContextRemoveProductRequest req) returns ContextProductListResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveProductRequest message;
        if req is ContextRemoveProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/RemoveProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductListResponse>result, headers: respHeaders};
    }

    isolated remote function ListAvailableProducts() returns ProductListResponse|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/ListAvailableProducts", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductListResponse>result;
    }

    isolated remote function ListAvailableProductsContext() returns ContextProductListResponse|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/ListAvailableProducts", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductListResponse>result, headers: respHeaders};
    }

    isolated remote function SearchProduct(SearchProductRequest|ContextSearchProductRequest req) returns SearchProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        SearchProductRequest message;
        if req is ContextSearchProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/SearchProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <SearchProductResponse>result;
    }

    isolated remote function SearchProductContext(SearchProductRequest|ContextSearchProductRequest req) returns ContextSearchProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        SearchProductRequest message;
        if req is ContextSearchProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/SearchProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <SearchProductResponse>result, headers: respHeaders};
    }

    isolated remote function AddToCart(AddToCartRequest|ContextAddToCartRequest req) returns grpc:Error? {
        map<string|string[]> headers = {};
        AddToCartRequest message;
        if req is ContextAddToCartRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        _ = check self.grpcClient->executeSimpleRPC("ShoppingService/AddToCart", message, headers);
    }

    isolated remote function AddToCartContext(AddToCartRequest|ContextAddToCartRequest req) returns empty:ContextNil|grpc:Error {
        map<string|string[]> headers = {};
        AddToCartRequest message;
        if req is ContextAddToCartRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/AddToCart", message, headers);
        [anydata, map<string|string[]>] [_, respHeaders] = payload;
        return {headers: respHeaders};
    }

    isolated remote function PlaceOrder(PlaceOrderRequest|ContextPlaceOrderRequest req) returns grpc:Error? {
        map<string|string[]> headers = {};
        PlaceOrderRequest message;
        if req is ContextPlaceOrderRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        _ = check self.grpcClient->executeSimpleRPC("ShoppingService/PlaceOrder", message, headers);
    }

    isolated remote function PlaceOrderContext(PlaceOrderRequest|ContextPlaceOrderRequest req) returns empty:ContextNil|grpc:Error {
        map<string|string[]> headers = {};
        PlaceOrderRequest message;
        if req is ContextPlaceOrderRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("ShoppingService/PlaceOrder", message, headers);
        [anydata, map<string|string[]>] [_, respHeaders] = payload;
        return {headers: respHeaders};
    }

    isolated remote function CreateUsers() returns CreateUsersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("ShoppingService/CreateUsers");
        return new CreateUsersStreamingClient(sClient);
    }
}

public isolated client class CreateUsersStreamingClient {
    private final grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendCreateUsersRequest(CreateUsersRequest message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextCreateUsersRequest(ContextCreateUsersRequest message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveCreateUsersResponse() returns CreateUsersResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <CreateUsersResponse>payload;
        }
    }

    isolated remote function receiveContextCreateUsersResponse() returns ContextCreateUsersResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <CreateUsersResponse>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public isolated client class ShoppingServiceProductCodeResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendProductCodeResponse(ProductCodeResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextProductCodeResponse(ContextProductCodeResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceSearchProductResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendSearchProductResponse(SearchProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextSearchProductResponse(ContextSearchProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceProductListResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendProductListResponse(ProductListResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextProductListResponse(ContextProductListResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceNilCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceCreateUsersResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCreateUsersResponse(CreateUsersResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCreateUsersResponse(ContextCreateUsersResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextCreateUsersRequestStream record {|
    stream<CreateUsersRequest, error?> content;
    map<string|string[]> headers;
|};

public type ContextProductListResponse record {|
    ProductListResponse content;
    map<string|string[]> headers;
|};

public type ContextProductCodeResponse record {|
    ProductCodeResponse content;
    map<string|string[]> headers;
|};

public type ContextPlaceOrderRequest record {|
    PlaceOrderRequest content;
    map<string|string[]> headers;
|};

public type ContextRemoveProductRequest record {|
    RemoveProductRequest content;
    map<string|string[]> headers;
|};

public type ContextSearchProductResponse record {|
    SearchProductResponse content;
    map<string|string[]> headers;
|};

public type ContextAddProductRequest record {|
    AddProductRequest content;
    map<string|string[]> headers;
|};

public type ContextUpdateProductRequest record {|
    UpdateProductRequest content;
    map<string|string[]> headers;
|};

public type ContextCreateUsersResponse record {|
    CreateUsersResponse content;
    map<string|string[]> headers;
|};

public type ContextSearchProductRequest record {|
    SearchProductRequest content;
    map<string|string[]> headers;
|};

public type ContextAddToCartRequest record {|
    AddToCartRequest content;
    map<string|string[]> headers;
|};

public type ContextCreateUsersRequest record {|
    CreateUsersRequest content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type Order record {|
    string user_id = "";
    Product[] products = [];
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type User record {|
    string user_id = "";
    string role = "";
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type Product record {|
    string name = "";
    string description = "";
    float price = 0.0;
    int stock_quantity = 0;
    string sku = "";
    string status = "";
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type AddProductRequest record {|
    Product product = {};
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type UpdateProductRequest record {|
    string sku = "";
    Product product = {};
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type SearchProductRequest record {|
    string sku = "";
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type AddToCartRequest record {|
    string user_id = "";
    string sku = "";
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type CreateUsersRequest record {|
    User user = {};
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type ProductListResponse record {|
    Product[] products = [];
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type ProductCodeResponse record {|
    string product_code = "";
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type PlaceOrderRequest record {|
    string user_id = "";
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type RemoveProductRequest record {|
    string sku = "";
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type SearchProductResponse record {|
    Product product = {};
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type CreateUsersResponse record {|
    string status = "";
|};

