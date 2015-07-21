def attributes_from_table(table)
  table.hashes.each_with_object({}) do |element, hash|
    hash[element['attribute']] = element['value']
    hash
  end
end

Given(/^a "(.*?)"$/) do |factory_name|
  @model_instance = create(factory_name.to_sym)
end

Given(/^a "(.*?)" with name "(.*?)"$/) do |factory_name, name|
  @model_instance = create(factory_name.to_sym, name: name)
end

Given(/^a "(.*?)" with the following data:$/) do |factory_name, table|
  @model_instance = create(factory_name.to_sym, attributes_from_table(table))
end
