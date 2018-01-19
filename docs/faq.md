## FAQ

**Q:** Why do we need more than just the regular "web publish" functionality from Visual Studio or MSBuild.exe?

**A:** Primarily because only the root `Web.config` is transformed by Visual Studio and MSBuild.exe. All our config include files etc. aren't transformed by MSBuilde.exe, we need to do this separately. 
Slow Cheetah would solve this in theory, but it brings it's own set of issues due to the custom build action it installs in `.csproj`-files.

---

**Q:** Can I use Slow Cheetah together with these scripts?

**A:** Yes and no. You CAN use the *Slow Cheetah Visual Studio Plugin* to preview XML Document Transforms; you CAN'T use the *Slow Cheetah NuGet Package* in any of your projects.
