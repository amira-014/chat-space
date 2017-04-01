# Design of ChatSpace Database




***

|groups   |       |      |
|:-------:|:-----:|:----:|
|columun  |type   |option|
|name     |string |none  |

##### relation
has_many :messages  
has_many :users, through => :groups_users

***

|users    |       |           |
|:-------:|:-----:|:---------:|
|columun  |type   |option     |
|name     |string |null: false|

##### relation
has_many :messages  
has_many :groups, through => :groups_users
##### index
add_index :users, :name

***

|groups_users |       |                 |
|:-----------:|:-----:|:---------------:|
|columun      |type   |option           |
|group_id     |integer|foreign_key: true|
|user_id      |integer|foreign_key: true|

##### relation
belongs_to :group  
belongs_to :user


***

|messages |       |                 |
|:-------:|:-----:|:---------------:|
|columun  |type   |option           |
|body     |text   |null: false      |
|image    |string |none             |
|group_id |integer|foreign_key: true|
|user_id  |integer|foreign_key: true|

##### relation
belongs_to :user  
belongs_to :group


***
