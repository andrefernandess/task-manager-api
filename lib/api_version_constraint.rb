class ApiVersionConstraint
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
     header_accept = "application/vnd.taskmanager.v#{@version}"
     @default || req.headers['Accept'].include?(header_accept)
  end
end
