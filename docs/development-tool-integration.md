## Development tool integration

### Visual Studio Task Runner

Use this [extension](https://marketplace.visualstudio.com/items?itemName=MadsKristensen.CommandTaskRunner) to enable support for PowerShell scripts via the Task Runner.

### NPM

Add a [script](https://docs.npmjs.com/misc/scripts) object to your package.json, if you're using [NPM as a build tool](https://www.keithcirkel.co.uk/how-to-use-npm-as-a-build-tool/):

```json
"scripts": {
    "publish-solution": "powershell Publish-ConfiguredWebSolution"
},
```

Run it using:

```bash
npm run publish-solution
```

### Gulp

Using a module that looks like this: 

```javascript
/*jslint node: true */
"use strict";

function Powershell () {
}

Powershell.prototype.runAsync = function (pathToScriptFile, parameters, callback) {
  console.log("Powershell - running: " + pathToScriptFile + " " + parameters);
  var spawn = require("child_process").spawn;
  var child = spawn("powershell.exe", [pathToScriptFile, parameters]);

  child.stdout.setEncoding('utf8')
  child.stderr.setEncoding('utf8')
  
  child.stdout.on("data", function (data) {
    console.log(data);
  });

  child.stderr.on("data", function (data) {
    console.log("Error: " + data);
  });

  child.on("exit", function () {
    console.log("Powershell - done running " + pathToScriptFile);
    if (callback)
      callback();
  });

  child.stdin.end();
}

exports = module.exports = new Powershell();
```

You can use it in your `gulpfile.js` like so:

```javascript
var powershell = require("./powershell");
powershell.runAsync("C:\path\to\your\file.ps1", "-arguments here", callback);
```
