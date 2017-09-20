require "./extensions"

SystemClient = require "./lib/system-client"

{system, application} = SystemClient()

{UI, Observable} = system

{Modal} = UI

Template = require "./templates/main"

element = Template
  open: ->
    Modal.prompt "Path", "somefile.txt"
    .then (result) ->
      if result
        system.readFile result
        .then (blob) ->
          if blob.type.match /^image/
            Image.fromBlob blob
            .then (img) ->
              document.body.appendChild img
          else if blob.type.match /^text/
            blob.readAsText().then (text) ->
              pre = document.createElement "pre"
              pre.textContent = text
              document.body.appendChild pre
          else
            console.warn "Can't yet handle ", blob.type

document.body.appendChild element
