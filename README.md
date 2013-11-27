
# TireUpdateByQuery


 扩展[retire](https://github.com/karmi/retire)与使用[elasticsearch-action-updatebyquery](https://github.com/yakaz/elasticsearch-action-updatebyquery)插件, 根据查询更新数据

## Installation
先安装[elasticsearch-action-updatebyquery](https://github.com/yakaz/elasticsearch-action-updatebyquery)

    gem 'tire_update_by_query', :github => "huxinghai1988/tire_update_by_query"


## Usage

    #数据
    {
      name: 'iPhone4',
      price: 4000,
      user:{
        id: 1,
        name: 'lisi'
      }
    }

    #更新user名称
    Model.index.update_by_query('type',
      :query => {
        :term => {
          :user_id => 1
        }
      },
      :update => {
        :user => {
          :name => 'lisitest'
        }
      }
    )

    #数据结果
    {
      name: 'iPhone4',
      price: 4000,
      user:{
        id: 1,
        name: 'lisitest'
      }
    }


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
