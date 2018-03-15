## Development tool integration

### Visual Studio Task Runner

Use this [extension](https://marketplace.visualstudio.com/items?itemName=MadsKristensen.CommandTaskRunner) to enable support for PowerShell scripts via the Task Runner.

### Visual Studio Context Menu entry
The following steps make the ``Publish-ConfiguredWebProject`` command available via the Visual Studio context menu.

#### Step 1: Add PowerShell as an External Tool
   1. Open Visual Studio.
   2. Open **Tools -> External Tools...** 

   ![Add PowerShell as External Tool step 1](/docs/images/vs-add-external-tool-step-1.png)

   3. Click the **Add** button.
   4. Set the **Title** to e.g. "Publish Configured Project".
   5. Set the **Command** to the default path for powershell.exe: `C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe`
   6. Set the **Arguments** to: `-Command "& {Import-Module Publish-WebProject; Publish-ConfiguredWebProject -WebProjectFilePath '$(ProjectFileName)' -Verbose;}"`
   7. Set the **Initial directory** to: `$(ProjectDir)`
   8. Count the position (starting from 1) of your command and remember this index number. *Visual Studio usually ships with **Create &GUID** tool, which is typically located at the top in first position.*

   ![Add PowerShell as External Tool step 2](/docs/images/vs-add-external-tool-step-2.png)

#### Step 2: Create the Context Menu entry
   1. Open **Tools -> Customize...**.
   2. Select the **Commands** tab.
   3. Click **Context menu** and select **Project and Solution Context Menus | Project**

   ![Add Context Menu entry step 1](/docs/images/vs-context-menu-step-1.png)

   4. Click **Add Command...** and from **Categories** select **Tools**.
   5. From **Commands** scroll down and select **External Command X** where "X" is the previously determined index.

   ![Add Context Menu entry step 2](/docs/images/vs-context-menu-step-2.png)

   6. Right click any project in your solution and run the publishing command. *NB: The `Publish-ConfiguredWebSolution` command must have been run at least once for the solution, as `Publish-ConfiguredWebProject` depends on user settings in `<solution root>\.pentia\user-settings.json`.*

   ![Publish project via Visual Studio Context Menu](/docs/images/vs-context-menu-step-3.png)

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
