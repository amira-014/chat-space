# Design of ChatSpace Database




***

|groups |      |       |
|:--—--:|:–---:|:-----:|
|columun|type  |option |
|name   |string|none   |

##### relation
has_many :messages  
has_many :groups, through => :groups_users

***

|users    |      |                          |
|:—------:|:----:|:------------------------:|
|columun  |type  |option                    |
|name     |string|null: false               |
|email    |string|null: false, unique: true |
|password |string|null: false               |

##### relation
has_many :messages  
has_many :groups, through => :groups_users

***

|groups_users|       |                  |
|:—---------:|:----—:|:----------------:|
|columun     |type   |option            |
|group_id    |integer|foreign_key: true |
|user_id     |integer|foreign_key: true |

##### relation
belongs_to :group  
belongs_to :user
##### index
add_index :groups_users, [:group_id, :user_id]

***

|messages |       |                  |
|:-------:|:-----:|:----------------:|
|columun  |type   |option            |
|body     |text   |none              |
|image    |text   |none              |
|group_id |integer|foreign_key: true |
|user_id  |integer|foreign_key: true |

##### relation
belongs_to :user  
belongs_to :group
##### index
add_index :messages, [:group_id, :user_id]

***
