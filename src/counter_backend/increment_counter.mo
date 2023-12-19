import Text "mo:base/Text";
import Nat "mo:base/Nat";

// Create a simple Counter actor.
actor Counter {
  stable var currentValue : Nat = 0;

  // Increment the counter with the increment function.
  public func increment() : async () {
    currentValue += 1;
  };

  // Read the counter value with a get function.
  public query func get() : async Nat {
    currentValue;
  };

  // Write an arbitrary value with a set function.
  public func set(n : Nat) : async () {
    currentValue := n;
  };

  public type HeaderField = (Text, Text);

  public type HttpRequest = {
    url : Text;
    method : Text;
    body : Blob;
    headers : [HeaderField];
  };

  public type HttpResponse = {
    body : Blob;
    headers : [HeaderField];
    // streaming_strategy : ?StreamingStrategy;
    status_code : Nat16;
  };

  public query func http_request(arg : HttpRequest) : async HttpResponse {
    let body = "<html><body><h1>Current Count: " # Nat.toText(currentValue) # "</h1></body></html>";
    return {
      body = Text.encodeUtf8(body);
      headers = [("Content-Type", "text/html")];
      status_code = 200;
    };
  };
};
