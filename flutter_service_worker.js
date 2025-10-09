'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "4961b0afa06ec6a0e0d19b689527f248",
".git/config": "52059308b39658aa8a55aff5e0a2bc44",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/FETCH_HEAD": "ac94d0ea98223a4e1383e0ab0a21c73f",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "c6b432f807b15ef3bf0679edea0a2e46",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "afb4c9169c30a5c6367be83b935fd14b",
".git/logs/refs/heads/main": "c9e910a72b2d5b292d4644b32cb80e09",
".git/logs/refs/remotes/origin/main": "6eb3ab0a0b79a2acaa7e94aa82a8cc06",
".git/objects/02/1d4f3579879a4ac147edbbd8ac2d91e2bc7323": "9e9721befbee4797263ad5370cd904ff",
".git/objects/0b/031dee7e11e60da63c8fe7fe6c0eea84ac5a6f": "ba829ebae934aa10500f6ff6db19d2cc",
".git/objects/0b/52e62fb881651820eb78e5990ccf8ffeaad4ab": "1da280043b99402780fd0db8da0a7fd9",
".git/objects/0d/1d848868fdb28e8d33dd980a80833722c0e705": "fe9ffc9b7a71231d8224ffca64373f8d",
".git/objects/0f/a280e9a35ae199fa79121667318a703073bfd6": "0830746132a86e1d340d83012c26aacd",
".git/objects/17/744a48681753ef0c3baa0be7a75df1cc1a8449": "eac02bbc29c105718519bf85cbcfef38",
".git/objects/17/e092a29c96e8cf2ff474731713efbb8574329e": "f6301567d92fc1e9574e28667be3a5c7",
".git/objects/20/1f33c32930fb401f878298aec48f0e0e8c0a60": "9cc158c281ec8dec3c45769074252b8c",
".git/objects/20/3a3ff5cc524ede7e585dff54454bd63a1b0f36": "4b23a88a964550066839c18c1b5c461e",
".git/objects/23/38324d380118ea88021ce7605cc9c6d00a6efe": "ba485da8e77c207e333d4661ab2f7efb",
".git/objects/26/6ea91202fe7ee10704cedf94e97a04c24c4014": "a9c13b006ea48294779f8381d9b9ccce",
".git/objects/27/b4f883000eef020a7e561e8d81a37f26675432": "37c8df72da7c34e799ca00a368bb4b0f",
".git/objects/29/30b81361ed99978292d94748ae8cfef3089c6c": "008bcc798e197a39c5c9db49be6fd89b",
".git/objects/29/9c9a517088827f7c6e261c50c17559e5522ae1": "1ac579ae6cf2bc946f75691b5442b2d1",
".git/objects/29/f22f56f0c9903bf90b2a78ef505b36d89a9725": "e85914d97d264694217ae7558d414e81",
".git/objects/31/7841310777dde4520561819da6f0f0c0471c4c": "b52ccebbaedd761840a44f69700704b5",
".git/objects/32/782ed884ac17fe6dfa929676ede8b87a2e493a": "63081b582d3a41b63b0cb1db520f0c79",
".git/objects/33/eda6a6edd79f5e8322fc090b64ee76f37964c7": "1c6860a8339cadd4a90c7b84a157ad3a",
".git/objects/3a/ce84dea034c4cace0d8322ec09c1a59028bc80": "c3186da8f9d94114a97db7984163c7be",
".git/objects/3d/c7db65cb15210f4855928373750d0f6e977f78": "05042be798d58d398a298846642b8cdb",
".git/objects/3f/61230143d7d727beb0e564d13fed4c744cceec": "07be5298d3c9a4ac2c7881a829762437",
".git/objects/42/f249c1fa7055456ac138c5c2732aa090dffed5": "63e27af5a6fc2512708cbe440946710f",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/47/7f8c445d70474ab21bec639230512e39def541": "4c0a8922c172b8830f8f3a6db89cf97c",
".git/objects/4b/047c8c326e9387b2c7af60604ce3f3803dd72f": "6dfb48323a1e2426a3d47e83d44edb5c",
".git/objects/4d/bf9da7bcce5387354fe394985b98ebae39df43": "534c022f4a0845274cbd61ff6c9c9c33",
".git/objects/4e/bde6eacf13ca5f4356bbcfb7d1d1e8657f1b20": "e85832d544a7f8bf33296548bb968291",
".git/objects/4e/e4972281ac36cbc3cda1e61f94eb9cafae53f3": "17bb0f669aabd94919d8aba4424bc1ef",
".git/objects/4f/abac0d8b32e1f8c173a33fe239e8f86dbd5edc": "302eed26c539f72ba4035bb8de3f6b44",
".git/objects/4f/fbe6ec4693664cb4ff395edf3d949bd4607391": "2beb9ca6c799e0ff64e0ad79f9e55e69",
".git/objects/54/8198f8ec409fcdc88a35fe7425652c39e476b8": "9a1e835a6fc527d71c1662459650ff8e",
".git/objects/60/128cd9feb42ac1e117e8eb826af400c0f42ffc": "65a05d8645f5e60b9611c63212e81411",
".git/objects/63/2532317e5d06a027d77115afd82c54aafbb7d2": "4d71e61375bd78976fafdbcd849d09f7",
".git/objects/63/44c6f7e14813192637bb4c939a536565fb21bf": "dc5e0cd325167eb19567631e962233d0",
".git/objects/6a/4758846ccca0fa7c057832fb06e649fd2cd5b5": "2dad4e2edc85963c7e24e93376673d9a",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/71/0fad74aeb3dc96a663814f4f59084ecbfb3102": "8b11448b16ade654c57e4d86a99c8872",
".git/objects/75/fc2643593d0d86de7b270a0dec19a7d9764374": "a352cad8293f26987ae73ccf61526d1a",
".git/objects/76/8aa458f020574480decd59beee7401bd9018c2": "74443fa880e6291031c0e074060f9e73",
".git/objects/76/9b112e89ae786bdbbbc883d830f95b07c0b219": "0fb99499ee46eb44febc0884ff781bc6",
".git/objects/78/1eb44b20c4f3981cf029c69b483b254b6233b8": "59c8b06016cac2c71ef149a3c48c003e",
".git/objects/7a/6c1911dddaea52e2dbffc15e45e428ec9a9915": "f1dee6885dc6f71f357a8e825bda0286",
".git/objects/7d/34272c04e0344df5b6a29b5c3dc2b7f534d3b1": "2bc087da8b10a7076c97ad851594eb77",
".git/objects/7d/ac8680582089ca3cd61ad60b81d4c3d4385791": "8c177fa9d8de175c18b16f66503abf79",
".git/objects/7e/31b515a93a7eb7d0f0ec7fa209405f6b2ed996": "b119777a4d8d84894aa8aab7d9a67f57",
".git/objects/82/552d33dd9f8f6362a864d5d9f55e76c16a1c4c": "27913a67f18cc8992f803c57f0da0f41",
".git/objects/87/ee0e1ed729c1c8535cf2cd15e73064620f045a": "fe14cd203d4b1f1aeae8399d332d1773",
".git/objects/87/f6a652911e0c0bc278f039803be3a627bd5f72": "53fb014eeb960b53ab4b118ee817281c",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/89/e73c98d053b892b0ed84ade4174903e0b87ad2": "ba9eb29b8d2f25df974663a70f835c10",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8c/dd99db8bca964cbe92eb88b8510c7d2d993fcd": "70b0c7b921fc16a00ef74002a40795db",
".git/objects/8e/44350f485ab54b41eadc2e8c659c4c263e9357": "9ad4c2dadf5279112b0eb97a684b2c32",
".git/objects/90/6646181b082002595b39f8da647667edfaad1b": "fbacf3e1c6bd2622449a4dc36e852725",
".git/objects/94/999f0c1252c4c0be91bb5d41fa0c1be05a6992": "d908aa07e000c600bc817466b94333e8",
".git/objects/95/d7b93424531b3f7143310634abe11706a3f0e1": "177f6193dfa6b22357b8ac17867fb8c5",
".git/objects/96/fe069b1bcf4aca314a3b711d019058f4fee01a": "bb8c5367cc013a6a16458ee3636a70a4",
".git/objects/98/0d49437042d93ffa850a60d02cef584a35a85c": "8e18e4c1b6c83800103ff097cc222444",
".git/objects/9b/3ef5f169177a64f91eafe11e52b58c60db3df2": "91d370e4f73d42e0a622f3e44af9e7b1",
".git/objects/9e/3b4630b3b8461ff43c272714e00bb47942263e": "accf36d08c0545fa02199021e5902d52",
".git/objects/9f/577c18905500083a870d7388d099048299f40f": "e3d034fef0ebc5ff5e011ac4fd9a90bc",
".git/objects/a3/619e7ddec5dfde8093433c3e3e5c6ce0801832": "5648e637af1405f3bd1574f77b3a06a7",
".git/objects/a7/04a8a82a464c10d71fc5157e43fa7fda330f39": "365d8b9a1857e7f78bd0d5fc1692f45d",
".git/objects/ae/51a00e360e3aa56512b4601a04a60d3c705b0d": "5a4de83452b04cfba6071d921c8dc4e0",
".git/objects/ae/a65e4bb061e62aad00363f4afeca8c53206575": "3a8b6bad55c14f39f7aeede7afd8f6e3",
".git/objects/b0/ad8a5460469b393ebcec84da6f6afd8381f2b6": "cda4f1a8bd0b476bbc5407d1f0c175d1",
".git/objects/b0/aec8d5746c55691ac57247d211b3e4a38f9aac": "9acf5959efed241fe54eb60bfc5eb0af",
".git/objects/b1/00964ed7a06efadac36b2b4d73d438bb600d03": "a92fbad402f080f1db2975a074ecefff",
".git/objects/b1/4bbae1889f3e3c65d3ac4f45162c2a22356120": "4b51acd3762e13fdbcb62b7be708ed40",
".git/objects/b6/b8806f5f9d33389d53c2868e6ea1aca7445229": "b14016efdbcda10804235f3a45562bbf",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b7/59d81b3a6558cd92b59fc88c60dd88dbad2958": "7f6e13c6d975c472a11696fad4f436ed",
".git/objects/b8/1cc572e39e633a7bdc25322862057a9c3593d1": "60525c435c0e9cd1cec1f2f99a29c88d",
".git/objects/b8/eed34c0406585c93827441c283ce893c7b317d": "e0dbda057badaf456126be2e033de7b0",
".git/objects/b8/f28c45176fd1a4c0a58e7e3bad8b4069fa3ea6": "26c0124c46eeab4ccfa055d5c97c9744",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/bb/6c534beeff072ac96a7bbd7b2f9b172234155e": "33adb4104e94b7894c23b9fd9f4133ef",
".git/objects/c4/016f7d68c0d70816a0c784867168ffa8f419e1": "fdf8b8a8484741e7a3a558ed9d22f21d",
".git/objects/c5/bb1a65c97ae0f96db0a530edcb02e478524fdc": "719d5927ef5463706b44817acd8b401f",
".git/objects/ca/3bba02c77c467ef18cffe2d4c857e003ad6d5d": "316e3d817e75cf7b1fd9b0226c088a43",
".git/objects/d0/e73680d51eac274211697a981eb326de04cf2f": "1236d073a6589c241ad6993cb0f01e49",
".git/objects/d4/1835539e9b728d5d27628455649f64da699ac2": "143eb1d1f7b9c472ac3394559cc83f50",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d8/3d1b146c339fd8d5a5d5a04f790d41f21fddb6": "a0a6fa8d222b9c6f41feefb5346a6a5a",
".git/objects/d9/529353b9742294e39eb923bd6f1bcbebd2a0f1": "c92ee004658f9418f568e83daef6f726",
".git/objects/dd/3790aafa142ebdbc327e2baf4f20073ef32404": "c88ea96c2d90d2a89e3ab7f0a64f12b1",
".git/objects/dd/8e066f4f9634ac07ca6fa2b941fff4edc5e213": "c48a9cfd37d2bce5034f7b9e6b1057da",
".git/objects/e1/d23ef8597f76057df2b7b48a3ced6af01ea370": "1262605341a5fe9d269fb34dc6604ffb",
".git/objects/e2/9b22ad56ef63180907ea36b4a3d442c1cf166b": "f81bc0653fc2a1e7c4e9dbedeb974166",
".git/objects/e3/6b63bae9923a52fec54839231d43e7ff3c303b": "e41885f8b848ac4213c022f98cbc6364",
".git/objects/e3/e9ee754c75ae07cc3d19f9b8c1e656cc4946a1": "14066365125dcce5aec8eb1454f0d127",
".git/objects/e5/38c60a5e3bffe03e0a2594b26e449f628ee8af": "1dc2f62e4948231bca3be0a8999cdb15",
".git/objects/e5/b887271a9be1c882945f11926ce217cad39b4c": "df93efd5449315650a6e9491ad5cc3a4",
".git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391": "c70c34cbeefd40e7c0149b7a0c2c64c2",
".git/objects/e9/1d11d06c2e6ee7ed7a129c1ad3730bbba61032": "00b085d070c463ef5b4da8f89e244903",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/eb/0762e2943ce61aae55b40e5ec5865b4f237606": "15cc291a2b0013404c2497ab113cdd41",
".git/objects/eb/3fd339a813e2601105310cc3a3a6a2f75933bc": "3fe7ed0341ec93a3c6e5b436181abcb2",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ec/2b84ba95d0992df075deab4b1e68708ae6049f": "16d9ec501276b98bb59cd2aef59fc9de",
".git/objects/ed/b55d4deb8363b6afa65df71d1f9fd8c7787f22": "886ebb77561ff26a755e09883903891d",
".git/objects/ef/5ece37584e58fd491038492adf741e6685c49a": "542e78363bda96f535ffc30f434e1487",
".git/objects/f1/06faeb4634962e8881bb6916c636d189fe33dd": "64b26c5327b15f17ee5ab9893ac758f6",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f2/af392fd5137f368bee615714f30592db99033b": "953cf38116d9fa8d0ee1de08bf841208",
".git/objects/f3/689d65c6d0fcc827b0077a9861d663de4a0498": "3374c4a49aecd7b254bbe0349d84132a",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/objects/f7/c9e6c2609cd65ee1e55f14f49e0f4e6836afbe": "b041c3078f92c2e099f01c1fb1b77753",
".git/objects/f8/409572b085fd3371d520230ca1c6c96ca8f71b": "4e041d68b6b1c60d0ff754b3c3f21775",
".git/objects/fa/3d06f0b58312fbd8951396e088802e3aa9da0d": "d18bbe41fc0f917f0e3e6160ab571c03",
".git/objects/fb/348d26578d75467d688af0dd3278ad16fd3271": "af4dffec5569b602229167ba2c9e67eb",
".git/objects/fb/5b2e7afcc68245d4fe53050a59ca65e4da3c28": "ae1101378625edd60688386d40a8ceba",
".git/objects/fb/923e9ee8a44b411eb85481904a2de28cd2296c": "ba8c419931080c87d5af5f136acbc5c0",
".git/objects/fc/ee511d4694159f469681c679a5bebc2b2244ae": "1bf35ca2a6459d2567a5facc7c838657",
".git/objects/fc/eef365e464cf58029f959fef44073a61c824a3": "a03191ff429a770f90ba730c4e9e2dcb",
".git/objects/fe/3b987e61ed346808d9aa023ce3073530ad7426": "dc7db10bf25046b27091222383ede515",
".git/ORIG_HEAD": "f68bf2b26f4275d24a6b3b93c924f99d",
".git/refs/heads/main": "66cb36413e1f13d9c83403666a6c9454",
".git/refs/remotes/origin/main": "66cb36413e1f13d9c83403666a6c9454",
"assets/AssetManifest.bin": "9ab81f792f7b6e75b42270c086c1bfd3",
"assets/AssetManifest.bin.json": "dc5a4f531e3056d27d8146ea5caa8a79",
"assets/AssetManifest.json": "ce80f8e4338261e4d649d06a39dc87a0",
"assets/assets/logo.jpeg": "c05c17cbec4eba252c392528d3b1d550",
"assets/assets/profile.png": "cd7a6a1a282caaac5f631fbe4b9a50cd",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "b7429112e2c4fbddf544fe0974d836ed",
"assets/logo.jpeg": "c05c17cbec4eba252c392528d3b1d550",
"assets/NOTICES": "89626590dcadd5bbc6595645f8ba44be",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/getwidget/icons/dribble.png": "1e36936e4411f32b0e28fd8335495647",
"assets/packages/getwidget/icons/facebook.png": "293dc099a89c74ae34a028b1ecd2c1f0",
"assets/packages/getwidget/icons/google.png": "596c5544c21e9d6cb02b0768f60f589a",
"assets/packages/getwidget/icons/line.png": "da8d1b531d8189396d68dfcd8cb37a79",
"assets/packages/getwidget/icons/linkedin.png": "822742104a63a720313f6a14d3134f61",
"assets/packages/getwidget/icons/pinterest.png": "d52ccb1e2a8277e4c37b27b234c9f931",
"assets/packages/getwidget/icons/slack.png": "19155b848beeb39c1ffcf743608e2fde",
"assets/packages/getwidget/icons/twitter.png": "caee56343a870ebd76a090642d838139",
"assets/packages/getwidget/icons/wechat.png": "ba10e8b2421bde565e50dfabc202feb7",
"assets/packages/getwidget/icons/whatsapp.png": "30632e569686a4b84cc68169fb9ce2e1",
"assets/packages/getwidget/icons/youtube.png": "1bfda73ab724ad40eb8601f1e7dbc1b9",
"assets/profile.png": "cd7a6a1a282caaac5f631fbe4b9a50cd",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "9b515756517a8cdf9030fc3b8b8d939d",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "acfffd1a083ede0eda1ab3d5f3f26ff8",
"/": "acfffd1a083ede0eda1ab3d5f3f26ff8",
"lib/dashboard.dart": "f1fa2f719b6c8b7f01b7670ae1737309",
"lib/detail_content.dart": "d6913da7c88f4eae4e4ecf1aae2d03ee",
"lib/detail_page.dart": "2668cfb284cacaa7031d200ec272299d",
"lib/login.dart": "585b4ac465e0fa32f306a34de771bb6f",
"lib/main.dart": "22e57405a5e75bed8de4e663af397514",
"lib/models/menu_model.dart": "f25185b5374362e35abd71555cb23abb",
"lib/profile_page.dart": "f6550a9eabe291eff05e129f1a0ea1db",
"lib/register.dart": "ee99e5de12432486239b6896fc55f724",
"lib/splash_screen.dart": "028d18324a2f6270341fd10929978843",
"lib/user_data.dart": "c1e39ac797d29acffeb42d9213ad3185",
"lib/utils/device_utils.dart": "d41d8cd98f00b204e9800998ecf8427e",
"lib/utils/shared_util.dart": "d41d8cd98f00b204e9800998ecf8427e",
"lib/widgets/about_widget.dart": "d41d8cd98f00b204e9800998ecf8427e",
"lib/widgets/history_item.dart": "d41d8cd98f00b204e9800998ecf8427e",
"lib/widgets/music.widget.dart": "d41d8cd98f00b204e9800998ecf8427e",
"lib/widgets/reflection_widget.dart": "d41d8cd98f00b204e9800998ecf8427e",
"lib/widgets/today_widget.dart": "ff4fe21eb4011d6dcc871433475c1047",
"main.dart.js": "75c3e71ba1b02879d9b7b1d534a4ad60",
"manifest.json": "bf24c84c3bf99672a631c4f84464e793",
"version.json": "15235b5108d6a877ef74fe3317a96bf7"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
