module Toggleable
  def method_missing(meth, *args, &block)
    if meth.to_s =~ /^toggle_(.+)$/
      toggle $1, *args, &block
    else
      super
    end
  end

  def toggle(bool_field, *args, &block)
    field_value = send bool_field
    update_attribute bool_field.to_sym, (not field_value)
  end
end
