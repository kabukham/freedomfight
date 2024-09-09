// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetAllEventsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetAllEvents {
      listFreedomFights(limit: 10, filter: {}) {
        __typename
        items {
          __typename
          dateTime
          address {
            __typename
            address1
            address2
            city
            county
            id
            state
            zipCode
          }
          description
          id
          image
          link
          name
        }
        nextToken
      }
    }
    """

  public let operationName: String = "GetAllEvents"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("listFreedomFights", arguments: ["limit": 10, "filter": [:]], type: .object(ListFreedomFight.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(listFreedomFights: ListFreedomFight? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "listFreedomFights": listFreedomFights.flatMap { (value: ListFreedomFight) -> ResultMap in value.resultMap }])
    }

    public var listFreedomFights: ListFreedomFight? {
      get {
        return (resultMap["listFreedomFights"] as? ResultMap).flatMap { ListFreedomFight(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "listFreedomFights")
      }
    }

    public struct ListFreedomFight: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["FreedomFightConnection"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("items", type: .list(.object(Item.selections))),
          GraphQLField("nextToken", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(items: [Item?]? = nil, nextToken: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "FreedomFightConnection", "items": items.flatMap { (value: [Item?]) -> [ResultMap?] in value.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } } }, "nextToken": nextToken])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var items: [Item?]? {
        get {
          return (resultMap["items"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Item?] in value.map { (value: ResultMap?) -> Item? in value.flatMap { (value: ResultMap) -> Item in Item(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Item?]) -> [ResultMap?] in value.map { (value: Item?) -> ResultMap? in value.flatMap { (value: Item) -> ResultMap in value.resultMap } } }, forKey: "items")
        }
      }

      public var nextToken: String? {
        get {
          return resultMap["nextToken"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "nextToken")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["FreedomFight"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("dateTime", type: .nonNull(.scalar(String.self))),
            GraphQLField("address", type: .object(Address.selections)),
            GraphQLField("description", type: .scalar(String.self)),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("image", type: .scalar(String.self)),
            GraphQLField("link", type: .scalar(String.self)),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(dateTime: String, address: Address? = nil, description: String? = nil, id: Int, image: String? = nil, link: String? = nil, name: String) {
          self.init(unsafeResultMap: ["__typename": "FreedomFight", "dateTime": dateTime, "address": address.flatMap { (value: Address) -> ResultMap in value.resultMap }, "description": description, "id": id, "image": image, "link": link, "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var dateTime: String {
          get {
            return resultMap["dateTime"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "dateTime")
          }
        }

        public var address: Address? {
          get {
            return (resultMap["address"] as? ResultMap).flatMap { Address(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "address")
          }
        }

        public var description: String? {
          get {
            return resultMap["description"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "description")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var image: String? {
          get {
            return resultMap["image"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "image")
          }
        }

        public var link: String? {
          get {
            return resultMap["link"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "link")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public struct Address: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Address"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("address1", type: .nonNull(.scalar(String.self))),
              GraphQLField("address2", type: .scalar(String.self)),
              GraphQLField("city", type: .nonNull(.scalar(String.self))),
              GraphQLField("county", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(Int.self))),
              GraphQLField("state", type: .nonNull(.scalar(String.self))),
              GraphQLField("zipCode", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(address1: String, address2: String? = nil, city: String, county: String, id: Int, state: String, zipCode: String) {
            self.init(unsafeResultMap: ["__typename": "Address", "address1": address1, "address2": address2, "city": city, "county": county, "id": id, "state": state, "zipCode": zipCode])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var address1: String {
            get {
              return resultMap["address1"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "address1")
            }
          }

          public var address2: String? {
            get {
              return resultMap["address2"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "address2")
            }
          }

          public var city: String {
            get {
              return resultMap["city"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "city")
            }
          }

          public var county: String {
            get {
              return resultMap["county"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "county")
            }
          }

          public var id: Int {
            get {
              return resultMap["id"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var state: String {
            get {
              return resultMap["state"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "state")
            }
          }

          public var zipCode: String {
            get {
              return resultMap["zipCode"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "zipCode")
            }
          }
        }
      }
    }
  }
}
