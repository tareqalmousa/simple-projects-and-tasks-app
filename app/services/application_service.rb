class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def result(is_success, error, result)
    OpenStruct.new(success?: is_success, result: result, error: error)
  end

end
