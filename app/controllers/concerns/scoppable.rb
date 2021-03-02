module Scoppable
  extend ActiveSupport::Concern

  def apply_scope(kclass, params)
    scoped = kclass


    params.each_key do |key|
      scoped = scoped.send(key, params[key]) if kclass.respond_to? key
    end

    scoped
  end
end
