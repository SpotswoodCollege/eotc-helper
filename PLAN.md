# eotc-helper Plan

## `User`

-   Devise setup: `:database_authenticatable, :confirmable, :registerable, :recoverable, :rememberable, :validatable, :trackable`
-   `role`: string
-   Can be `standard`, `teacher`, `coordinator`, or `administrator`
-   Method for checking if a given user has a given role (or greater)

### Schema:

| Attribute      | Type           | Notes          |
| :------------- | :------------- | :------------- |
| Devise columns | Many           | -              |
| `role`         | `string`       | See List A     |
| `created_at`   | `datetime`     | Rails standard |
| `updated_at`   | `datetime`     | Rails standard |

### List A

`role` can be one of the following:

-   `standard`
-   `teacher`
-   `senior_teacher`
-   `coordinator`
-   `principal`
-   `board`
-   `administrator`

### Relations

```ruby
has_many :subscriptions
has_many :groups, through: :subscriptions

has_many :activities, through: :groups
```

## `Subscription`

-   Links `Users` and `Groups`

### Schema:

| Attribute      | Type           | Notes          |
| :------------- | :------------- | :------------- |
| `user_id`      | `bigint`       | -              |
| `group_id`     | `bigint`       | -              |
| `created_at`   | `datetime`     | Rails standard |
| `updated_at`   | `datetime`     | Rails standard |

### Relations

```ruby
belongs_to :user
belongs_to :group
```

## `Group`

-   Has and belongs to many `Activities`
-   Has and belongs to many `Users`
-   Can be created by teachers
-   Can be updated / destroyed by administrators and creators
-   Has subscribe/unsubscribe button

### Schema:

| Attribute      | Type           | Notes          |
| :------------- | :------------- | :------------- |
| `name`         | `string`       | -              |
| `description`  | `text`         | -              |
| `creator`      | `integer`      | User ID        |
| `created_at`   | `datetime`     | Rails standard |
| `updated_at`   | `datetime`     | Rails standard |

### Relations

```ruby
has_many :subscriptions
has_many :users, through: :subscriptions

has_many :assignments
has_many :activities, through: :assignments
```

## `Assignment`

-   Links `Groups` and `Activities`

### Schema:

| Attribute      | Type           | Notes          |
| :------------- | :------------- | :------------- |
| `activity_id`  | `bigint`       | -              |
| `group_id`     | `bigint`       | -              |
| `created_at`   | `datetime`     | Rails standard |
| `updated_at`   | `datetime`     | Rails standard |

### Relations

```ruby
belongs_to :group
belongs_to :activity
```

## `Activity`

-   Has and belongs to many `Groups`
-   Can be created by teachers
-   Can be updated / destroyed by administrators and creators

### Schema:

| Attribute      | Type           | Notes          |
| :------------- | :------------- | :------------- |
| `name`         | `string`       | Unique         |
| `description`  | `text`         | -              |
| `type`         | `string`       | See List A     |
| `risk`         | `string`       | See List B     |
| `edited_at`    | `datetime`     | Updated on edit |
| `approved_at`  | `datetime`     | Updated on approve |
| `occurs_at`    | `datetime`     | -              |
| `finishes_at`  | `datetime`     | -              |
| `creator`      | `integer`      | User ID of creator |
| `created_at`   | `datetime`     | Rails standard |
| `updated_at`   | `datetime`     | Rails standard |

### List A

`type` can be one of the following:

-   `in_school`
-   `community`
-   `day_trip`
-   `multi_day`

### List B

`risk` can be either `low` or `high`.



### Relations

```ruby
has_many :assignments
has_many :groups, through: :assignments

has_many :users, through: :groups
```
