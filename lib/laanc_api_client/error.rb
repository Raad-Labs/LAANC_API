module LaancApiClient
  class Error < StandardError; end
  class AuthenticationError < Error; end
  class AuthorizationError < Error; end
  class BadRequestError < Error; end
  class NotFoundError < Error; end
  class InternalServerError < Error; end
  class ForbiddenError < Error; end
  class GoneError < Error; end
end