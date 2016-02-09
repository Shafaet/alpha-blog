require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
	
	def setup
		@Category = Category.new(name: "sports")
	end

	test "Category should be valid" do
		assert @Category.valid?
	end

	test "Name should be present" do
		@Category.name = " "
		assert_not @Category.valid?
	end

	test "Name should be unique" do
		@Category.save
		Category2= Category.new(name: "sports")
		assert_not Category2.valid?
	end

	test "Name should not be too long" do
		@Category.name = "a" *26
		assert_not @Category.valid?
	end

	test "Name should not be too short" do
		@Category.name = "a" * 2
		assert_not @Category.valid?
	end

end