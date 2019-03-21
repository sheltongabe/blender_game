// Auto-generated
let project = new Project('game');

project.addSources('Sources');
project.addLibrary("/home/dev/Downloads/Armory_06beta_linux64/Armory/armsdk/armory");
project.addLibrary("/home/dev/Downloads/Armory_06beta_linux64/Armory/armsdk/iron");
project.addLibrary("/home/dev/Downloads/Armory_06beta_linux64/Armory/armsdk/lib/haxebullet");
project.addAssets("/home/dev/Downloads/Armory_06beta_linux64/Armory/armsdk/lib/haxebullet/ammo/ammo.js", { notinlist: true });
project.addParameter('armory.trait.physics.bullet.PhysicsWorld');
project.addParameter("--macro keep('armory.trait.physics.bullet.PhysicsWorld')");
project.addParameter('arm.PlayerMovement');
project.addParameter("--macro keep('arm.PlayerMovement')");
project.addParameter('armory.trait.physics.bullet.RigidBody');
project.addParameter("--macro keep('armory.trait.physics.bullet.RigidBody')");
project.addShaders("build_game/compiled/Shaders/*.glsl");
project.addAssets("build_game/compiled/Assets/**", { notinlist: true });
project.addAssets("build_game/compiled/Shaders/*.arm", { notinlist: true });
project.addAssets("/home/dev/Downloads/Armory_06beta_linux64/Armory/armsdk/armory/Assets/brdf.png", { notinlist: true });
project.addAssets("/home/dev/Downloads/Armory_06beta_linux64/Armory/armsdk/armory/Assets/noise256.png", { notinlist: true });
project.addAssets("/home/dev/Downloads/Armory_06beta_linux64/Armory/armsdk/armory/Assets/smaa_area.png", { notinlist: true });
project.addAssets("/home/dev/Downloads/Armory_06beta_linux64/Armory/armsdk/armory/Assets/smaa_search.png", { notinlist: true });
project.addDefine('arm_deferred');
project.addDefine('arm_csm');
project.addDefine('rp_hdr');
project.addDefine('rp_renderer=Deferred');
project.addDefine('rp_depthprepass');
project.addDefine('rp_shadowmap');
project.addDefine('rp_shadowmap_cascade=1024');
project.addDefine('rp_shadowmap_cube=512');
project.addDefine('rp_background=World');
project.addDefine('rp_render_to_texture');
project.addDefine('rp_compositornodes');
project.addDefine('rp_antialiasing=SMAA');
project.addDefine('rp_supersampling=1');
project.addDefine('rp_ssgi=SSAO');
project.addDefine('rp_gi=Off');
project.addDefine('arm_physics');
project.addDefine('arm_bullet');
project.addDefine('arm_shaderload');
project.addDefine('arm_soundcompress');
project.addDefine('arm_skin');
project.addDefine('arm_particles_gpu');
project.addDefine('arm_particles');


resolve(project);
