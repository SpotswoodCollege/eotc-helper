# eotc-helper Plan

## `User`

-   Devise setup: `:database_authenticatable, :confirmable, :registerable, :recoverable, :rememberable, :validatable, :trackable`
-   `role`: string
-   Can be `standard`, `teacher`, `coordinator`, or `administrator`
-   Method for checking if a given user has a given role (or greater)

```ruby
has_many :subscriptions
has_many :groups, through: :subscriptions

has_many :activities, through: :groups
```

## `Subscription`

-   Links `Users` and `Groups`

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

```ruby
has_many :subscriptions
has_many :users, through: :subscriptions

has_many :assignments
has_many :activities, through: :assignments
```

## `Assignment`

-   Links `Groups` and `Activities`

```ruby
belongs_to :group
belongs_to :activity
```

## `Activity`

-   Has and belongs to many `Groups`
-   `name`: string
-   `type`: string
    -   `:in_school`
    -   `:short`
    -   `:long`
    -   `:non_regional`
-   `risk`: string
    -   `:low_risk`
    -   `:high-risk`
-   Can be created by teachers
-   Can be updated / destroyed by administrators and creators

```ruby
has_many :assignments
has_many :groups, through: :assignments

has_many :users, through: :groups
```
