module ModelMacros
  def expect_destroyed_orphan(object)
    expect{ object.reload }.to raise_exception(ActiveRecord::RecordNotFound)
  end
end