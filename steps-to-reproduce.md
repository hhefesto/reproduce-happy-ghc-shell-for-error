# Document Title

Easiest way to reproduce would be to just call `nix develop github:hhefesto/reproduce-happy-ghc-shell-for-error`

```sh
$ nix shell github:nixos/nixpkgs#stack github:input-output-hk/haskell.nix#hix
$ stack new hello-world simple
$ cd hello-world
$ ls
CHANGELOG.md  hello-world.cabal  LICENSE  README.md  Setup.hs  src  stack.yaml
$ git init
$ hix init
$ # change resolver in stack.yaml to `resolver: lts-20.1`
$ rm -r nix
$ # simple changes to flake.nix to remove hix, change hixProject to hello-world and add packages.default
$ git add -A
$ nix develop --show-trace       
warning: Git tree '/home/hhefesto/src/hello-world' is dirty
warning: Using saved setting for 'allow-import-from-derivation = true' from ~/.local/share/nix/trusted-settings.json.
warning: Using saved setting for 'extra-substituters = https://cache.iog.io' from ~/.local/share/nix/trusted-settings.json.
warning: Using saved setting for 'extra-trusted-public-keys = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=' from ~/.local/share/nix/trusted-settings.json.
trace: WARNING: `cleanSourceWith` called on /nix/store/pc6d01rd1473z5783nv30nx6kn4877fh-source without a `name`. Consider adding `name = "pc6d01rd1473z5783nv30nx6kn4877fh-source";`
trace: WARNING: `cleanSourceWith` called on /nix/store/pc6d01rd1473z5783nv30nx6kn4877fh-source without a `name`. Consider adding `name = "pc6d01rd1473z5783nv30nx6kn4877fh-source";`
trace: No index state specified for alex, using the latest index state that we know about (2022-11-25T00:00:00Z)!
trace: No index state specified for happy, using the latest index state that we know about (2022-11-25T00:00:00Z)!
error: builder for '/nix/store/z1yrpnsxhpablg92idq7731dpf2bbiqy-happy-plan-to-nix-pkgs.drv' failed with exit code 1;
       last 10 log lines:
       > base-4.9.0.0, base-4.8.2.0, base-4.8.1.0, base-4.8.0.0, base-4.7.0.2,
       > base-4.7.0.1, base-4.7.0.0, base-4.6.0.1, base-4.6.0.0, base-4.5.1.0,
       > base-4.5.0.0, base-4.4.1.0, base-4.4.0.0, base-4.3.1.0, base-4.3.0.0,
       > base-4.2.0.2, base-4.2.0.1, base-4.2.0.0, base-4.1.0.0, base-4.0.0.0,
       > base-3.0.3.2, base-3.0.3.1 (has the same characteristics that caused the
       > previous version to fail: excluded by constraint '<0' from 'happy')
       > [__1] fail (backjumping, conflict set: base, happy)
       > After searching the rest of the dependency tree exhaustively, these were the
       > goals I've had most trouble fulfilling: happy, base
       >
       For full logs, run 'nix log /nix/store/z1yrpnsxhpablg92idq7731dpf2bbiqy-happy-plan-to-nix-pkgs.drv'.

       … while realising the context of path '/nix/store/d2893yvfllh5r2z6nrnij63h5k46xlfl-happy-plan-to-nix-pkgs'

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/lib/import-and-filter-project.nix:18:13:

           17|   projectSubDir'' = if projectSubDir == "" then "" else projectSubDir + "/"; # With trailing /
           18|   project = import "${projectNix}${projectSubDir'}";
             |             ^
           19| in project // {

       … while evaluating anonymous lambda

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/lib/import-and-filter-project.nix:5:1:

            4| { pkgs, haskellLib }:
            5| { projectNix, sourceRepos, src }:
             | ^
            6| let

       … from call site

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/overlays/haskell.nix:516:27:

          515|               callProjectResults = callCabalProjectToNix args;
          516|               plan-pkgs = importAndFilterProject {
             |                           ^
          517|                 inherit (callProjectResults) projectNix sourceRepos src;

       … while evaluating the attribute 'pkg-set'

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/overlays/haskell.nix:548:26:

          547|                   inherit (pkg-set.config) hsPkgs;
          548|                   inherit pkg-set;
             |                          ^
          549|                   plan-nix = callProjectResults.projectNix;

       … while evaluating 'getPackage'

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/overlays/haskell.nix:705:26:

          704|             # cabal configure errors are defered until the components derivation builds.
          705|             getPackage = packageName:
             |                          ^
          706|               if rawProject.pkg-set ? configurationError

       … from call site

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/overlays/haskell.nix:501:14:

          500|           let project = hackage-project projectModule;
          501|           in project.getPackage project.args.name;
             |              ^
          502|         hackage-project = projectModule:

       … while evaluating 'hackage-package'

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/overlays/haskell.nix:499:27:

          498|         # is required, a specific index-state should be provided!
          499|         hackage-package = projectModule:
             |                           ^
          500|           let project = hackage-project projectModule;

       … from call site

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/overlays/tools.nix:62:17:

           61|     let
           62|       package = final.haskell-nix.hackage-package (projectModules ++ [
             |                 ^
           63|           ({lib, ...}: {

       … while evaluating 'hackage-tool'

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/overlays/tools.nix:60:18:

           59|
           60|   hackage-tool = projectModules:
             |                  ^
           61|     let

       … from call site

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/overlays/tools.nix:78:7:

           77|   tool = compiler-nix-name: name: versionOrMod:
           78|       final.haskell-nix.hackage-tool (
             |       ^
           79|            final.haskell-nix.haskellLib.versionOrModToMods versionOrMod

       … while evaluating 'tool'

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/overlays/tools.nix:77:35:

           76|
           77|   tool = compiler-nix-name: name: versionOrMod:
             |                                   ^
           78|       final.haskell-nix.hackage-tool (

       … from call site

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/modules/configuration-nix.nix:116:6:

          115|     (pkgs.buildPackages.haskell-nix.tool config.compiler.nix-name "alex" {})
          116|     (pkgs.buildPackages.haskell-nix.tool config.compiler.nix-name "happy" {})
             |      ^
          117|   ];

       … while evaluating the attribute 'value'

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/modules/plan.nix:46:38:

           45|               elemType
           46|               [{ inherit (def) file; value = def'; }]
             |                                      ^
           47|             ).optionalValue

       … while evaluating 'dischargeProperties'

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/lib/modules.nix:805:25:

          804|   */
          805|   dischargeProperties = def:
             |                         ^
          806|     if def._type or "" == "merge" then

       … from call site

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/lib/modules.nix:734:137:

          733|         defs' = concatMap (m:
          734|           map (value: { inherit (m) file; inherit value; }) (builtins.addErrorContext "while evaluating definitions from `${m.file}':" (dischargeProperties m.value))
             |                                                                                                                                         ^
          735|         ) defs;

       … while evaluating definitions from `/nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/modules/configuration-nix.nix':

       … while evaluating anonymous lambda

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/lib/modules.nix:733:28:

          732|         # Process mkMerge and mkIf properties.
          733|         defs' = concatMap (m:
             |                            ^
          734|           map (value: { inherit (m) file; inherit value; }) (builtins.addErrorContext "while evaluating definitions from `${m.file}':" (dischargeProperties m.value))

       … from call site

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/lib/modules.nix:733:17:

          732|         # Process mkMerge and mkIf properties.
          733|         defs' = concatMap (m:
             |                 ^
          734|           map (value: { inherit (m) file; inherit value; }) (builtins.addErrorContext "while evaluating definitions from `${m.file}':" (dischargeProperties m.value))

       … while evaluating the attribute 'values'

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/lib/modules.nix:846:7:

          845|     in {
          846|       values = concatMap (def: if getPrio def == highestPrio then [(strip def)] else []) defs;
             |       ^
          847|       inherit highestPrio;

       … while evaluating the attribute 'values'

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/lib/modules.nix:747:9:

          746|       in {
          747|         values = defs''';
             |         ^
          748|         inherit (defs'') highestPrio;

       … while evaluating the attribute 'optionalValue'

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/lib/modules.nix:765:5:

          764|
          765|     optionalValue =
             |     ^
          766|       if isDefined then { value = mergedValue; }

       … while evaluating anonymous lambda

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/modules/plan.nix:42:21:

           41|         if isList def.value then
           42|           imap1 (m: def':
             |                     ^
           43|             (mergeDefinitions

       … from call site

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/lib/lists.nix:117:32:

          116|   */
          117|   imap1 = f: list: genList (n: f (n + 1) (elemAt list n)) (length list);
             |                                ^
          118|

       … while evaluating anonymous lambda

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/lib/lists.nix:117:29:

          116|   */
          117|   imap1 = f: list: genList (n: f (n + 1) (elemAt list n)) (length list);
             |                             ^
          118|

       … from call site

       … while evaluating anonymous lambda

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/modules/plan.nix:40:33:

           39|     merge = loc: defs:
           40|       map (x: x.value) (filter (x: x ? value && x.value != null) (concatLists (imap1 (n: def:
             |                                 ^
           41|         if isList def.value then

       … from call site

       … while evaluating 'merge'

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/modules/plan.nix:39:18:

           38|     # Mostly copied from nixpkgs/lib/types.nix
           39|     merge = loc: defs:
             |                  ^
           40|       map (x: x.value) (filter (x: x ? value && x.value != null) (concatLists (imap1 (n: def:

       … from call site

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/lib/modules.nix:755:59:

          754|       if isDefined then
          755|         if all (def: type.check def.value) defsFinal then type.merge loc defsFinal
             |                                                           ^
          756|         else let allInvalid = filter (def: ! type.check def.value) defsFinal;

       … while evaluating the attribute 'mergedValue'

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/lib/modules.nix:753:5:

          752|     # Type-check the remaining definitions, and merge them. Or throw if no definitions.
          753|     mergedValue =
             |     ^
          754|       if isDefined then

       … while evaluating the option `packages.Sit.components.library.build-tools':

       … while evaluating the attribute 'value'

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/lib/modules.nix:719:9:

          718|     in warnDeprecation opt //
          719|       { value = builtins.addErrorContext "while evaluating the option `${showOption loc}':" value;
             |         ^
          720|         inherit (res.defsFinal') highestPrio;

       … while evaluating anonymous lambda

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/lib/modules.nix:268:72:

          267|           # For definitions that have an associated option
          268|           declaredConfig = mapAttrsRecursiveCond (v: ! isOption v) (_: v: v.value) options;
             |                                                                        ^
          269|

       … from call site

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/lib/attrsets.nix:401:20:

          400|               then recurse (path ++ [name]) value
          401|               else f (path ++ [name]) value;
             |                    ^
          402|         in mapAttrs g;

       … while evaluating 'g'

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/lib/attrsets.nix:398:19:

          397|           g =
          398|             name: value:
             |                   ^
          399|             if isAttrs value && cond value

       … from call site

       … while evaluating the attribute 'executableToolDepends'

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/builder/comp-builder.nix:349:14:

          348|       srcSubDirPath = cleanSrc.root + cleanSrc.subDir;
          349|       inherit configFiles executableToolDepends exeName enableDWARF;
             |              ^
          350|       exePath = drv + "/bin/${exeName}";

       … while evaluating anonymous lambda

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/builder/shell-for.nix:110:37:

          109|   nativeBuildInputs = removeSelectedInputs
          110|     (uniqueWithName (lib.concatMap (c: c.executableToolDepends)
             |                                     ^
          111|       # When not using `exactDeps` cabal may try to build arbitrary dependencies

       … from call site

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/builder/shell-for.nix:110:22:

          109|   nativeBuildInputs = removeSelectedInputs
          110|     (uniqueWithName (lib.concatMap (c: c.executableToolDepends)
             |                      ^
          111|       # When not using `exactDeps` cabal may try to build arbitrary dependencies

       … while evaluating 'uniqueWithName'

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/builder/shell-for.nix:102:20:

          101|   # Version of `lib.unique` that should be fast if the name attributes are unique
          102|   uniqueWithName = list:
             |                    ^
          103|     lib.concatMap lib.unique (

       … from call site

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/builder/shell-for.nix:110:6:

          109|   nativeBuildInputs = removeSelectedInputs
          110|     (uniqueWithName (lib.concatMap (c: c.executableToolDepends)
             |      ^
          111|       # When not using `exactDeps` cabal may try to build arbitrary dependencies

       … while evaluating the attribute 'nativeBuildInputs'

       at /nix/store/71dx5w39446f1gycg3z8rb7yavpc3i54-source/builder/shell-for.nix:169:5:

          168|       ++ mkDrvArgs.buildInputs or [];
          169|     nativeBuildInputs = [ ghcEnv ]
             |     ^
          170|       ++ nativeBuildInputs

       … while evaluating 'mergeInputs'

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/pkgs/build-support/mkshell/default.nix:17:17:

           16| let
           17|   mergeInputs = name:
             |                 ^
           18|     (attrs.${name} or [ ]) ++

       … from call site

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/pkgs/build-support/mkshell/default.nix:37:36:

           36|   buildInputs = mergeInputs "buildInputs";
           37|   nativeBuildInputs = packages ++ (mergeInputs "nativeBuildInputs");
             |                                    ^
           38|   propagatedBuildInputs = mergeInputs "propagatedBuildInputs";

       … while evaluating 'imap1'

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/lib/lists.nix:117:14:

          116|   */
          117|   imap1 = f: list: genList (n: f (n + 1) (elemAt list n)) (length list);
             |              ^
          118|

       … from call site

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/lib/trivial.nix:138:19:

          137|   */
          138|   flip = f: a: b: f b a;
             |                   ^
          139|

       … while evaluating 'flip'

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/lib/trivial.nix:138:16:

          137|   */
          138|   flip = f: a: b: f b a;
             |                ^
          139|

       … from call site

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/pkgs/stdenv/generic/make-derivation.nix:192:49:

          191|   checkDependencyList = checkDependencyList' [];
          192|   checkDependencyList' = positions: name: deps: lib.flip lib.imap1 deps (index: dep:
             |                                                 ^
          193|     if lib.isDerivation dep || isNull dep || builtins.typeOf dep == "string" || builtins.typeOf dep == "path" then dep

       … while evaluating 'checkDependencyList''

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/pkgs/stdenv/generic/make-derivation.nix:192:43:

          191|   checkDependencyList = checkDependencyList' [];
          192|   checkDependencyList' = positions: name: deps: lib.flip lib.imap1 deps (index: dep:
             |                                           ^
          193|     if lib.isDerivation dep || isNull dep || builtins.typeOf dep == "string" || builtins.typeOf dep == "path" then dep

       … from call site

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/pkgs/stdenv/generic/make-derivation.nix:212:41:

          211|       (map (drv: drv.__spliced.buildBuild or drv) (checkDependencyList "depsBuildBuild" depsBuildBuild))
          212|       (map (drv: drv.nativeDrv or drv) (checkDependencyList "nativeBuildInputs" nativeBuildInputs
             |                                         ^
          213|          ++ lib.optional separateDebugInfo' ../../build-support/setup-hooks/separate-debug-info.sh

       … while evaluating 'chooseDevOutputs'

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/lib/attrsets.nix:609:22:

          608|   /* Pick the outputs of packages to place in buildInputs */
          609|   chooseDevOutputs = drvs: builtins.map getDev drvs;
             |                      ^
          610|

       … from call site

       … while evaluating the attribute 'nativeBuildInputs' of the derivation 'ghc-shell-for-hello-world'

       at /nix/store/xxs457ajxj8fjm2shjmik6mdz2spyjzy-source/pkgs/stdenv/generic/make-derivation.nix:270:7:

          269|     // (lib.optionalAttrs (attrs ? name || (attrs ? pname && attrs ? version)) {
          270|       name =
             |       ^
          271|         let
```
