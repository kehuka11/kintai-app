module Application
  class AppUserService
    def register(cmd)
      raise NotImplementedError, 'implement in subclass'
    end
  end
end
