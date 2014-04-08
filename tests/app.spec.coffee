describe 'Application startup', ->
    it 'creates an app variable in global scope', ->
        expect(window.app).toBeDefined()