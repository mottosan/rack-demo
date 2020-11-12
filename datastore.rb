require "./errors"

module Datastore
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods
    DB = {}
    def find_by_id(id)
      if val = DB[id]
        val
      else
        raise ObjectNotFound, "object with id #{id} not found"
      end
    end

    def find_all
      DB.values
    end

    def create(params)
      id = (DB.keys.max || -1).to_i + 1
      DB[id.to_s] = params.merge("id"=> id.to_s)
    end

    def update(id, params)
      if val = DB[id]
        DB[id] = val.merge params.select { |k| val.keys.include? k }
      else
        raise ObjectNotFound, "object with id #{id} not found"
      end
    end

    def delete(id)
      if val = DB[id]
        DB.delete(id)
      else
        raise ObjectNotFound, "object with id #{id} not found"
      end
    end
  end
end
