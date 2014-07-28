require 'test_helper'
require 'rabbitstream'

describe Rabbitstream do

  describe "without a target" do
    before do
      @actor = mock()
      @actor.expects(:class).at_least_once.returns("Rebel")
      @actor.stubs(:to_param).returns(1)
      @verb = :smoke
      @object = mock()
      @object.expects(:class).at_least_once.returns("BigJoint")
      @object.stubs(:to_param).returns(2)
      @activity = Rabbitstream::Activity.new(@actor, @verb, @object)
    end

    it "should make key without target" do
      @activity.key.must_equal "rebel.smoke.big_joint"
    end

    it "should underscore the classes in json" do
      hash = @activity.as_json
      hash[:actor][:object_type].must_equal "rebel"
      hash[:object][:object_type].must_equal "big_joint"
    end

    it "should set a published time" do
      @published_at = Time.now
      Time.stubs(:now).returns(@published_at)
      hash = @activity.as_json
      hash[:published].must_equal @published_at.iso8601
    end
  end

  describe "with a target" do
    before do
      @actor = mock()
      @actor.expects(:class).at_least_once.returns("Principal")
      @actor.stubs(:to_param).returns(1)
      @verb = :expel
      @object = mock()
      @object.expects(:class).at_least_once.returns("Rebel")
      @object.stubs(:to_param).returns(1)
      @target = mock()
      @target.expects(:class).at_least_once.returns("School")
      @target.stubs(:to_param).returns(5)
      @target.stubs(:nil?).returns(false)
      @activity = Rabbitstream::Activity.new(@actor, @verb, @object, @target)
    end

    it "should make key with target" do
      @activity.key.must_equal "principal.expel.rebel.school"
    end

    it "should underscore the classes in json" do
      hash = @activity.as_json
      hash[:actor][:object_type].must_equal "principal"
      hash[:object][:object_type].must_equal "rebel"
      hash[:target][:object_type].must_equal "school"
    end
  end

end
