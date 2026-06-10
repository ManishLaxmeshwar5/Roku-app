function __tests_BaseTestSuite_builder()
    instance = __rooibos_BaseTestSuite_builder()
    instance.super0_new = instance.new
    instance.new = sub()
        m.super0_new()
        m.appController = invalid
    end sub
    instance.super0_setup = instance.setup
    instance.setup = function()
        'Do something here all your files need
        'like setup the logger, etc
    end function
    instance.super0_beforeEach = instance.beforeEach
    instance.beforeEach = function()
        'do things here that all your tests need
        'e.g. for a maestro app
        ' m.appController = { "id": "appController" }
        ' mioc.setInstance("appController", m.appController)
    end function
    instance.super0_afterEach = instance.afterEach
    instance.afterEach = function()
        'tidy things up
        'e.g. for a maestro app
        ' mioc.reset()
        ' mioc.clearClassInstances()
        ' if m.global.__mioc <> invalid
        '   m.global.__mioc = invalid
        ' end if
    end function
    return instance
end function
function tests_BaseTestSuite()
    instance = __tests_BaseTestSuite_builder()
    instance.new()
    return instance
end function
'//# sourceMappingURL=./BaseTestSuite.spec.brs.map