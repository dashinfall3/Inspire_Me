RSpec::Matchers.define :have_link_to do |expected|
  match do |actual|
    actual.should have_selector("a[href='#{expected}']")
  end

  description do
    "contains a link to \"#{expected}\""
  end
end
