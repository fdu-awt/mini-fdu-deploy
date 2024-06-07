-- prepare mysql
-- create database
DROP DATABASE IF EXISTS mini_fdu;
CREATE DATABASE IF NOT EXISTS mini_fdu;
-- create user and grant privileges
CREATE USER IF NOT EXISTS 'mini_fdu_admin'@'%' IDENTIFIED BY 'password123';
GRANT ALL PRIVILEGES ON mini_fdu.* TO 'mini_fdu_admin'@'%';
FLUSH PRIVILEGES;

USE mini_fdu;
SET FOREIGN_KEY_CHECKS = 0;
-- ------------------------------------------------------------------------------------------------------------------
-- ------------------------------------user-service------------------------------------------------------------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`
(
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `self_image` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

INSERT INTO `user` (`name`, `email`, `password`,`self_image`) VALUES
    ('Violette', 'violette@example.com', 'violette123','Doctor');

INSERT INTO `user` (`name`, `email`, `password`,`self_image`) VALUES
    ('Rosy', 'rosy@example.com', 'rosy123','Doctor');

INSERT INTO `user` (`name`, `email`, `password`,`self_image`) VALUES
    ('ZMark', 'zmark@example.com', 'zmark123','BusinessMan');

INSERT INTO `user` (`name`, `email`, `password`,`self_image`) VALUES
    ('chenbuchen', 'chenbuchen@example.com', 'chenbuchen123','FireFighter');

-- ----------------------------------study-service--------------------------------------------------------------------------------
-- ----------------------------
-- Table structure for `history`
-- ----------------------------

DROP TABLE IF EXISTS `history`;
CREATE TABLE `history`
(
    `id`    INT          NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(255) NOT NULL COMMENT '历史故事标题',
    `intro` TEXT         NOT NULL COMMENT '历史故事简介',
    `image` VARCHAR(255) NOT NULL COMMENT '历史故事图片的文件名',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;


-- ----------------------------
-- Table structure for `club`
-- ----------------------------

DROP TABLE IF EXISTS `club`;
CREATE TABLE `club`
(
    `id`       INT          NOT NULL AUTO_INCREMENT,
    `name`     VARCHAR(255) NOT NULL COMMENT '社团名称',
    `slogan`   VARCHAR(255) NOT NULL COMMENT '社团口号',
    `intro`    TEXT         NOT NULL COMMENT '社团简介',
    `profile`  VARCHAR(255) NOT NULL COMMENT '社团头像图片的文件名',
    `activity` VARCHAR(255) NOT NULL COMMENT '社团活动图片的文件名',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;


-- ----------------------------
-- Table structure for `quiz`
-- ----------------------------

DROP TABLE IF EXISTS `quiz`;
CREATE TABLE `quiz`
(
    `id`       INT          NOT NULL AUTO_INCREMENT,
    `topic`    VARCHAR(255) NOT NULL COMMENT '知识的类型，目前有club或history',
    `data_id`  INT          NOT NULL COMMENT '关联的知识对应的前端数据集中id',
    `question` VARCHAR(255) NOT NULL COMMENT '测试问题',
    `options`  VARCHAR(255) NOT NULL COMMENT '每个问题有若干个可选答案（默认为4个），答案以"|"分割，如 "1902年|1905年|1911年|1908年"',
    `answer`   VARCHAR(255) NOT NULL COMMENT '正确答案，如"1902年"',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;


-- ----------------------------
-- Table structure for `quiz_record`
-- ----------------------------

DROP TABLE IF EXISTS `quiz_record`;
CREATE TABLE `quiz_record`
(
    `id`               INT          NOT NULL AUTO_INCREMENT,
    `user_id`          INT          NOT NULL,
    `quiz_id`          INT          NOT NULL,
    `answer`           VARCHAR(255) NOT NULL COMMENT '用户回答',
    `is_correct`       BOOLEAN      NOT NULL COMMENT '该次回答是否正确',
    `create_timestamp` TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '答题时间',
    PRIMARY KEY (`id`),
    FOREIGN KEY (`quiz_id`) REFERENCES quiz (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;


-- ----------------------------
-- Table structure for `recommend_link`
-- ----------------------------

DROP TABLE IF EXISTS `recommend_link`;
CREATE TABLE `recommend_link`
(
    `id`    INT          NOT NULL AUTO_INCREMENT,
    `topic` VARCHAR(255) NOT NULL COMMENT '推荐的链接主题',
    `title` VARCHAR(255) NOT NULL COMMENT '推荐的链接标题',
    `link`  VARCHAR(255) NOT NULL COMMENT '推荐学习的链接',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;


-- ---------------------
-- Data for `history`
-- ---------------------

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (1, '肇始吴淞',
        '（1905—1911，校址：吴淞）1902年，马相伯倾其家产，借天主教徐家汇天文台余屋为校舍，创办震旦学院。1905年，为反抗教会势力干预校政，于右任、邵力子等130名学生愤然脱离震旦，支持马相伯在吴淞复校。1905年9月14日（阴历八月十六），国人自办的第一所高等学校——复旦公学在上海吴淞提督行辕正式开学。',
        '1.jpg');

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (2, '迁址徐汇',
        '（1912—1917，复旦公学；1917-1922，私立复旦大学，校址：徐家汇）辛亥革命时，吴淞校舍为光复军司令部占用，复旦公学一度停办。中华民国建立后，复旦校友于右任时任交通次长，联合校友41人上书南京临时政府，请求复校，得孙中山鼎力支持。复旦公学成为临时政府批准立案的唯一高校。临时政府还拨款一万元作为复校经费。后复旦公学借徐家汇李公祠为校舍，1912—1922年在此办学。',
        '2.jpg');

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (3, '奠基江湾',
        '（1922—1937，私立复旦大学，校址：江湾）1918年，校长李登辉到南洋募集资金15万银元，在江湾购地70余亩。1920年冬，复旦大学在江湾奠基。从此学校拥有永久校地。1929年，复旦大学根据《大学组织法》进行改组，设立文理法商四个学院，院系组织结构更趋完善，私立复旦大学进入黄金时期。',
        '3.jpg');

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (4, '西迁重庆',
        '抗战爆发后，部分师生被迫辗转迁移至重庆北碚，在嘉陵江畔建成战时校园（渝校），形成文理法商农5院20余系的规模。滞留上海的师生另组“上海补习部”（沪校），在租界继续办学，坚持“三不原则”，维护了民族气节。1942年，复旦大学（渝校）由私立改为国立，办学条件大为改善，名师云集，学术活跃，使复旦所在地夏坝成为大后方的文化重阵。抗战胜利后，复旦（渝校）于1946年夏离渝返沪，重回江湾原址，与沪校合并。国立复旦大学办学规模进一步扩大。',
        '4.jpg');

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (5, '第一次腾飞',
        '1949年5月27日上海解放，复旦历史翻开新的一页。1952年全国高校院系调整，奠定了复旦以文理为基础的综合性重点大学的基础。1959年5月，复旦大学被认定为全国十六所重点高校之一，进入国家重点建设大学之列，实现了复旦大学历史上的第一次腾飞。',
        '5.jpg');

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (6, '第二次腾飞',
        '1978年2月，国务院批准教育部《关于恢复和办好全国重点高等学校的报告》，复旦再次被确定为全国重点高校。1984年4月，复旦大学被国务院确定为“七五”期间重点建设单位。几年的迅速发展使复旦成为全国文理科综合性重点大学，并跨入全国首批“211工程”高校建设行列，实现了历史上的第二次腾飞。',
        '6.jpg');

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (7, '强强联合',
        '（2000—2010，复旦大学，校址：邯郸路、枫林路、淞沪路、张衡路）2000年4月27日，复旦大学与上海医科大学强强联合，组建新的复旦大学。复旦发展成为文理医三足鼎立，在国内外享有盛誉的综合性研究型大学。2005年，复旦大学隆重庆祝建校一百周年，进一步明确了建设具有世界一流水平的社会主义综合性大学的目标。探索贯通本科教育全过程的通识教育新模式，打造以培养探究能力为核心的拔尖创新人才培养体系。校地扩展为邯郸、枫林、江湾、张江四校区。',
        '7.jpg');

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (8, '迈向顶尖',
        '学校正按照党和国家的要求，以习近平新时代中国特色社会主义思想为指导，深入贯彻党的十九大和全国教育大会精神，落实立德树人根本任务，坚持改革开放、创新引领、内涵发展，加快推进“双一流”建设，全面开启中国特色世界顶尖大学建设新征程，为加快推进教育现代化、建设教育强国、办好人民满意的教育，为实现中华民族伟大复兴的中国梦作出无愧于时代的新贡献！立德树人固根本，改革开放再出发，全面开启中国特色世界顶尖大学建设新征程。',
        '8.jpg');

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (9, '烽火中的复旦（一）内迁之路',
        '1938年，在抗日战争的连绵烽火中，地处上海江湾的复旦校址被日军炮火炸成废墟，为了保存教育科研火种，复旦师生被迫踏上内迁之路，经过千里跋涉、辗转迁徙，最终在北碚夏坝建校复课，再续弦歌。同一时期，上海医学院也历经坎坷，先迁昆明白龙潭，后落脚重庆沙坪坝。在大后方，复旦师生同心一德、爱国救亡，追求进步、团结牺牲，弦歌不辍、硕果累累，书写了复旦大学历史上的光辉一页。复旦大学抗战内迁80周年时，学校纪念了这一历史性的迁徙，并通过《烽火中的复旦》一书，让后人重温那段充满挑战与奋斗的历史，传承并激发着新时代的复旦精神。这段历史不仅是对过去的回顾，也是对未来的启迪，鼓励着每一位复旦人继续在新时代中爱国奋斗，为国家的文化和教育事业贡献力量。',
        '9.jpg');

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (10, '烽火中的复旦（二）首创联大 护校西迁',
        '1937年，由于抗日战争的爆发，复旦大学在上海江湾的校园遭到破坏，秋季学期开学变得不可能。面对困境，复旦决定借用海格路附属实验中学继续办学。随后，根据教育部的指示，复旦大学与大夏大学、光华大学和大同大学共同组织了联合大学，计划自筹经费内迁。尽管光华和大同因资金问题退出，复旦和大夏还是决定继续联合内迁，并于9月末成立了复旦大夏联合大学。10月底，900余名复旦师生抵达庐山，利用普仁医院作为教室开课。但随着日军威胁的增加，学校再次被迫迁移，这次是前往四川，并计划与已迁至贵阳的第二部汇合。12月初，复旦师生乘船离开庐山，经过20多天的艰苦跋涉，最终到达重庆。由于贵阳校舍紧张，复旦大夏联合大学在1938年2月决定解体，复旦和大夏分别在重庆和贵阳继续办学，从而结束了联合大学的使命。这段历史反映了复旦师生在战争与动荡中的坚持和牺牲，以及对学术和教育的不懈追求。',
        '10.jpg');

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (11, '烽火中的复旦（三）煤栈茅屋 建校夏坝',
        '1938年2月，面对战争带来的破坏和资源匮乏，复旦大学从重庆菜园坝复旦中学迁移到北碚黄桷树镇，开始了一段艰难的重建之路。学校在东阳镇征购土地时，得到了当地士绅和民众的广泛支持，这不仅体现了复旦在当地的影响力，也反映了地方政府对高等教育的重视。在四川人民的慷慨支持下，复旦大学得以建立永久校址，并设立了嘉陵纱厂纪念奖，以帮助经济困难的学生。尽管生活条件艰苦，师生们仍展现出了坚韧不拔的精神，同心协力在嘉陵江畔建设新校园。1939年3月21日，复旦大学在北碚的新校区正式开学，开启了为期八年的办学历程。在这段艰难岁月中，复旦大学不仅得到了当地民众的大力支持，也通过教育和文化活动，回馈了当地社会，展现了大学在战时的文化引领作用和社会责任。这段历史成为了复旦大学校史上不可或缺的一部分，也是复旦精神的重要体现。',
        '11.jpg');

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (12, '烽火中的复旦（四）筚路蓝缕 国立存校',
        '在抗日战争时期，复旦大学面临严峻挑战，师生们在物质匮乏的环境中仍坚持学术追求。经济困难迫使学校申请国立，1941年11月，国民政府批准复旦大学改为国立大学，解决了债务问题，为学校发展带来转机。1939年，复旦创始人马相伯逝世，校友为纪念他发起募捐，建立图书馆和百龄堂，激励国人和师生共同抗日。1943年，章益担任校长，致力于提升教育质量，力争使复旦成为国际知名大学。抗战期间，660余名复旦学子参军，学校还承担译员训练任务，支持盟军。在师生共同努力下，复旦大学声誉日增，抗战胜利时已成为国内顶尖大学，体现了复旦人的坚韧和对国家的贡献。',
        '12.jpg');

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (13, '烽火中的复旦（五）学规论衡 良师济济',
        '在1938至1946年的抗战时期，复旦大学在困境中不断发展壮大，增设了十余个学系，并在1940年成立了农学院，形成了文、理、法、商、农五院二十余系的规模，为未来的人才培养打下了坚实基础。学校坚持基础知识教学，扩大学生知识面，实行必修与选修课相结合的课程设置，并在1942年改为国立后，显著提升了教学和科研质量。战时复旦特别注重学生的实践能力培养，鼓励学生主动性，强调理论联系实际。师资力量是学校的核心竞争力，复旦的名师阵营在战时坚守教育文化，丰富了复旦精神，其中不乏中国现代学界的泰斗和名流。尽管生活困难，复旦教师们依然坚持教学和科研，他们的学术成果不仅奠定了复旦学人在中国学术、教育和文化思想史上的地位，也体现了复旦人对民族兴亡和历史变化的深刻思考。这一时期，复旦大学的教学科研成就突出，展现了广大知识分子的坚守和担当。',
        '13.jpg');

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (14, '烽火中的复旦（六）社团林立 英才辈出',
        '战时复旦大学的社团活动为文化建设贡献显著，特别是1938年成立的抗战文艺习作会，它通过研究抗战文艺和组织救亡活动，发扬了抗敌精神。复旦剧社也是戏剧界的重要力量，具有深远的文化影响。在北碚，师生们在艰苦条件下举办了多样的文体活动，如演讲和球类比赛，同时积极进行社会服务，如民众学校，丰富了当地文化生活。学校还邀请了众多名人演讲，促进了学术自由和思想争鸣，为学生提供了广泛的学术视野。这段艰苦岁月中，复旦大学不仅培养了学生的学术素养，也塑造了他们的青春情怀，展现了复旦人坚韧不拔、追求卓越的精神。',
        '14.jpg');

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (15, '烽火中的复旦（七）艰辛回迁 重聚江湾',
        '1945年日本投降后，复旦大学开始了从战时内迁地返回上海的复员工作。校长章益亲赴上海，慰问师生并协调复员事宜。由于战争破坏，复旦江湾校区受损严重，但师生及校友坚决反对迁校他地，坚持返回上海。1946年初，复旦启动东迁行动，成立迁校委员会，由章益校长领导。7月，师生员工分批抵达宝鸡，面临资金和交通挑战，最终在9月抵达上海。回迁过程虽然艰难，但复旦人对学校的忠诚和对教育的执着得以体现，成功返回上海后，复旦大学继续其教育使命，再续辉煌。',
        '15.jpg');

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (16, '烽火中的复旦（八）正义之旅 多难兴邦',
        '1940年5月27日，日军轰炸北碚，复旦大学遭受重创，包括教务长孙寒冰教授在内的7人罹难，数十人受伤。孙寒冰教授始终坚持抗战，是复旦精神的象征。复旦师生在战争中表现出色，积极参与抗日救亡活动，马相伯校长号召青年以科学和民众力量救国。从1941年至1944年，667名复旦学子投身军旅，包括翻译官、远征军等，他们在抗战中提供了重要的翻译服务。1944年，面对日军威胁，复旦学子愤慨请缨，直接参战。1945年4月，复旦师生在北碚码头欢送从军同学，他们的勇气和牺牲精神成为复旦的骄傲，永远铭记在心。',
        '16.jpg');

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (17, '玖园建筑群',
        '玖园，作为复旦大学第九宿舍的雅称，不仅是一段历史的见证，更是复旦精神的象征。这里曾是众多学术巨匠的居住地，其中包括《共产党宣言》中文全译本的首译者陈望道教授。玖园一期陈望道旧居经过修缮，转变为《共产党宣言》展示馆，与苏步青旧居、谈家桢（陈建功）旧居一同，构成了爱国主义教育建筑群。这些旧居的修缮和开放，不仅保护了丰富的红色资源，也使得玖园成为了展现复旦学术传统、承载复旦精神、丰富校园文化、凝聚师生力量的重要场所。2018年5月，展示馆以“信仰之源”为主题，系统地展示了《共产党宣言》的诞生、传播、翻译及其对中国历史发展的巨大影响，成为党史、校史教育基地，同时也是上海乃至全国的红色地标。玖园的修缮工作体现了复旦大学对历史建筑保护的重视，以及对文化传承与创新的追求。',
        '17.jpg');

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (18, '复旦大学校史馆',
        '复旦大学校史馆，其前身是1921年建成的奕住堂，这幢中西合璧的建筑采用了混凝土模仿中国古典木结构柱子和铁制中国式花格窗，展现了独特的建筑艺术风格。奕住堂最初作为办公楼使用，后逐渐转变为图书馆，并在1929年扩建后更名为仙舟图书馆。2005年，经过精心修缮的“700号”楼，即奕住堂，被赋予了新的使命，成为了复旦大学校史馆。校史馆以其朱砂红色的外观设计和内部的雕梁画栋，成为校园内最具中式风格的建筑之一。馆内展出了1000余件珍贵的校史文物，包括上世纪20年代的毕业文凭、孙中山为复旦学子题写的“天下为公”和“努力前程”的题词等，生动地呈现了复旦大学百余年的发展脉络和办学成就。校史馆不仅是历史的展示，更是对未来学子的启迪和教育，体现了复旦大学深厚的历史底蕴和学术传统。',
        '18.jpg');

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (19, '相辉堂',
        '相辉堂，原名登辉堂，是一幢承载着复旦大学历史变迁的标志性建筑。1947年建成的相辉堂，以其简洁而注重功能的建筑立面，青瓦白砖的设计风格，成为了当时校园内的主要教学和集会场所。1985年，登辉堂更名为相辉堂。2017年，复旦大学对这座年逾古稀的大礼堂进行了修缮保护，一楼的旧教室和阅览室被改造为多功能用房，而二楼的大礼堂则保留了原有的风貌。修缮后的相辉堂不仅复原了历史模样，更增添了现代剧场所需的灯光、音响、舞台机械和全媒体设施，使其成为了一个能够满足高级别演出需求的现代化场馆。相辉堂的每一次修缮和扩建，都见证了复旦的发展和时代的变迁，它不仅是复旦人记忆中的重要部分，也是复旦故事继续展开的舞台。',
        '19.jpg');

INSERT INTO `history` (`id`, `title`, `intro`, `image`)
VALUES (20, '枫林校区东一号楼',
        '枫林校区东一号楼是复旦大学上海医学院历史最悠久的建筑，以其独特的中国传统官式建筑风格和明黄色琉璃瓦顶而著称。这幢建筑不仅在外观上展现了中西合璧的美学特色，更在医学教育和研究中发挥了重要作用。东一号楼内曾设有多个基础医学学科教研室、公共卫生学教研室、教室、图书馆、大礼堂等重要设施，是医学教育的核心区域。校史馆位于东一号楼3楼，藏有157件珍贵的校史文物，全面展示了医学院从1927年到2000年间的发展历程。此外，颜福庆雕塑——医学院创始人颜福庆先生的石像，也位于东一号楼北侧的福庆广场，激励着一代又一代的医学学子。东一号楼不仅是医学知识的殿堂，更是医学精神的象征，承载着医学院的历史和文化。',
        '20.jpg');

-- ---------------------
-- Data for `club`
-- ---------------------

INSERT INTO `club` (`id`, `name`, `slogan`, `intro`, `profile`, `activity`)
VALUES (1, '尤克里里社', '披音乐星光，传弦歌魅力',
        '尤克里里社是一个以音乐为媒介，聚集音乐爱好者的社团。社团活动多样，从光草弹唱到公益音乐会，尤克里里社不仅在校园内引领音乐风潮，也将音乐的魅力带到了社会公益中。尤克里里小巧便携，音色清脆，尤其适合演绎活泼欢快的歌曲。很多乐器需要专门的地点和专门的时间来演练，尤克里里则能让音乐无处不在。尤克里里特别的音色乍一看是一种局限，但其实小小的琴上四根弦，可以创造无限的可能。复旦尤克里里社正如这四根琴弦一样，简单地开始，又一步步成长为校园音乐的引领者、传播者。“我们这样的兴趣社团，发展起来像在风雨飘摇中航行的轮船。在控制航向的过程中，自己的心智得到了锻炼，最终尤克里里社承载的就不仅仅是音乐。”',
        '1.jpg', '2.jpg');

INSERT INTO `club` (`id`, `name`, `slogan`, `intro`, `profile`, `activity`)
VALUES (2, '钢琴协会', '以琴会友，以声寻梦，以乐传承',
        '很多人认为钢琴是一门“高冷”的艺术，然而钢琴协会对于音乐的态度，恰恰与“高冷”相反，他们致力于打造的，是一个以分享为核心的爱乐平台，让爱乐者可以在自由的交流中提升音乐修养。钢协的前副会长表示，“钢琴审美并没有硬性标准，任何人都可以从感性的角度去认识它，你能感受到它的美妙，那就是感受到了。音乐带给我们的享受应当是纯粹的，没有必要因为认识方式的差别感到负担。”钢协有着先进的自审意识和管理体系，他们保持积极的革新，跳出模式固化的圈囿。从前钢协的核心是围绕演奏团开展的一条培养路线，在钢琴沙龙中对演奏团的同学进行演奏能力的指导，再到乐理集训营中提高他们的音乐理解。由于演奏团有一定的考核要求，基础不够的同学可能无法体验到较高的获得感。对此钢协针对更大的受众进行了改良，增加感性审美层面的分享，试图在艺术修养提升上惠及全校同学，而不只是演奏团成员。',
        '3.jpg', '4.jpg');

INSERT INTO `club` (`id`, `name`, `slogan`, `intro`, `profile`, `activity`)
VALUES (3, '国标舞协', 'To dance, to live, to be.',
        '国标舞协拥有近27年的历史，是复旦大学的一支重要舞蹈力量。社团成员积极参与国内外舞蹈比赛，并在维也纳中国新年舞会上展现舞艺。国标舞协注重舞蹈的艺术性和竞技性，每学期举办高质量的专场舞会，通过一整个学期的筹备和排练，呈现精彩的舞蹈表演。国标舞协鼓励零基础的同学勇敢地尝试展示自己，在招新面试中，比起花哨的舞蹈技巧，国标舞协更看重的一个人是否对舞蹈有真切的热爱。生命的最高艺术或许就是带着偏偏起舞一般的浪漫与激情，尽力过好每一天。To dance, to live, to be. ——这是复旦国标舞协人让生命起舞的态度。',
        '5.jpg', '6.jpg');

INSERT INTO `club` (`id`, `name`, `slogan`, `intro`, `profile`, `activity`)
VALUES (4, '演讲与口才协会', '宁鸣而死，不默而生',
        '演讲与口才协会通过语言艺术探索真理，鼓励成员勇于表达自己的观点。协会分为朗诵组、演讲组和辩论组，各自开展不同形式的活动。朗诵组以夜诵和新声诵诗会为特色，强调声音的美妙和诗歌的感染力。演讲组注重演讲的共鸣和共情，帮助成员成为负责任的表达者。辩论组则通过辩论活动，培养成员的思考方式和包容心态。协会通过新生演讲赛和新生辩论赛等活动，为成员提供展示和锻炼的平台。',
        '7.jpg', '8.jpg');

INSERT INTO `club` (`id`, `name`, `slogan`, `intro`, `profile`, `activity`)
VALUES (5, '天文协会', '漫天星辰愿作你最深沉的寄托',
        '星海璀璨熠耀，宇宙浩瀚无垠，每每仰望，总是能触动古今之人无尽的神思遐想，也成就了一代又一代上下求索的天文人。怀着对宇宙星河最纯粹最赤诚的热爱与向往，出于对天文领域科研知识的探索与渴望，天文协会的成员们如繁星般相遇，汇聚彼此的光芒，星河流淌二十载，照亮了更为广阔的苍穹。路边天文是天文协会的标志性活动之一，具有无法比拟的日常性与容纳性。每一个晴朗的星夜都可以在光草东侧进行观测，欢迎每一位同学前来参与，已成为天文爱好者们最为便捷的交流平台。此外，天文协会自创办以来坚持“普及天文知识，探索宇宙自然”的宗旨，推动校内外天文科普工作的开展，积极助力国家科普事业发展。“在我的理解中，天协是一个理想、包容而又纯粹的组织。它既可以容纳专业能力爆表的‘大佬’，也接受所有怀着热爱的‘小白’，它更像是搭建在天文爱好者之间的一个交流平台，不管是谁都能在天协有不同的收获。”',
        '9.jpg', '10.jpg');

INSERT INTO `club` (`id`, `name`, `slogan`, `intro`, `profile`, `activity`)
VALUES (6, '复旦心脑学社', 'Discover the mystery in your mind.',
        '当你在阅读文章，思考字句的含义，脑海里浮现出一些画面，这一系列看似寻常的过程全都归功于大脑的飞速运转，而你是否也会运用大脑来思考大脑本身的奥秘呢？脑是人体最为复杂的器官，脑科学便是一门揭示大脑奥秘的学科，致力于探索生命科学研究的“终极疆域”，脑科学与人工智能已成为当今国际科技前沿热点。复旦大学类脑智能与科学技术研究院（以下简称类脑研究院）是国内高校最早成立的脑科学与类脑前沿交叉研究机构之一，下设生物医学大数据中心——复旦张江国际脑库（ZIB），是上海市脑与类脑市级重大专项支持建设的重要基础设施平台。依托于顶尖脑科学研究平台，2021年初张江国际脑库学生协会正式创办，2022年更名为复旦心脑学社。作为一颗冉冉升起的学术类社团新星，复旦心脑学社将坚持创办初衷，致力于人工智能与脑科学学术活动交流及参观，着眼于科学技术前沿探索、推动前沿科学理论和技术探讨，促进学科交叉融合及学术交流，充分发挥学生社团对科学技术前沿和未来创新发展的作用。',
        '11.jpg', '12.jpg');

INSERT INTO `club` (`id`, `name`, `slogan`, `intro`, `profile`, `activity`)
VALUES (7, '智能机器人创新社', '机器人是科幻致于现实的浪漫',
        '该如何诠释不同专业的浪漫呢？也许是文学的句句情诗，数学的心形函数，而对于复旦大学智能机器人创新社的工科同学们来说，他们最大的浪漫就是机器人。正如社团的口号所言：“机器人是科幻致于现实的浪漫。”（Robotic is Romantic science fiction written for reality.）他们是最硬核的浪漫复旦人。复旦大学智能机器人创新社（Romantic and Robotic）成立于2019年，是由一群人工智能和机器人爱好者组成的学术兴趣社团，覆盖本科生和研究生，也是目前复旦大学校内最大的工科社团。智能机器人创新社拥有机器识别、目标追踪、路径规划、多智能体决策、物理仿真等软实力，又有电控、机器人改造等硬实力。社团将积极邀请业界学界的学者进行科普演讲，并组织成系列讲座发布，帮助校内同学开阔视野，了解前沿业界信息。未来希望更多热爱机器人，热爱钻研机器人技术科研难关的同学们加入社团，从研究生向本科生扩展，做到多学科交叉融合相互交流，做到科普与学术、兴趣与科研的有机结合。',
        '13.jpg', '14.jpg');

INSERT INTO `club` (`id`, `name`, `slogan`, `intro`, `profile`, `activity`)
VALUES (8, '生态自然科考协会', '探索自然界的奥秘',
        '春有百花秋有月，夏有凉风冬有雪。再全面的百科全书也写不尽自然的魅力，生态自然科考协会成立的初心，便是不局限于在书本里窥探世界，而是要带着科学的态度观察世界、感受世界。自创办以来，生态自然科考协会推出了野外考察、科普讲座、手工艺品制作、社会实践、生态文创、公益科普支教等一系列主题活动，在科研中深入自然探索，在实践中感悟自然魅力，在科普中发挥公益力量，是引领复旦学子深度兴趣学习的“第二课堂”。生态自然科考协会的创意策划组策划过武功山考察、鄱阳湖调研等多个野外考察活动，报名人数累计超过300人次，广受复旦学子好评。成员们驻足过武功山的深壑幽谷，欣赏过鄱阳湖的碧波秀屿，感叹过莫干山的烟遮树藏……通过亲自走进大自然，成员们观察壮丽伟大的地理景观，寻觅难得一见的神秘物种，深刻体会到科学考察的重要性，也收获了友情与难忘的人生经历。',
        '15.jpg', '16.jpg');

INSERT INTO `club` (`id`, `name`, `slogan`, `intro`, `profile`, `activity`)
VALUES (9, '爱和猫协', '科普爱猫知识，关注校园猫咪，爱和你在一起',
        '复旦大学爱和猫协是一个致力于关爱校园流浪猫的公益社团。他们的主要工作包括科普爱猫知识，进行校园内猫咪的绝育、救助和领养工作。爱和猫协成立于2013年，最初是一个混合型的志愿服务社团，2016年转型成为专门为猫服务的社团。社团内部分为宣传、喵创工坊、救助支援、绝育领养和科普等五个小组，各司其职，共同为校园流浪猫的福祉而努力。爱和猫协的成员们不仅关心猫咪的健康和生活，还通过各种方式向校园师生普及科学养猫、喂猫的知识，提高大家的动物保护意识。他们通过微信公众号、微博等社交平台发布猫咪的日常动态和领养信息，吸引了许多爱猫人士的关注和支持。此外，爱和猫协还经常组织募捐和义卖活动，为流浪猫的医疗和养护筹集资金。爱和猫协的成员们因爱猫而聚，他们熟悉校园里每一只猫的名字和故事，为它们建小房子，制作专属明信片，让复旦的流浪猫在流浪生涯中也能感受到家的温暖。他们相信，通过大家的共同努力，可以为校园流浪猫创造一个更加和谐的生存环境。',
        '17.jpg', '18.jpg');

INSERT INTO `club` (`id`, `name`, `slogan`, `intro`, `profile`, `activity`)
VALUES (10, 'FudanACMICPC', '破题于弹指之间',
        '编程中的“算法”一词，指的并不是计算某个数学题的方法。通俗的来讲，算法就是解决某个问题的操作流程。算法在我们的生活中无处不在。进入大数据时代，每时每刻都有无数的数据需要计算机处理。不同的算法消耗的时间长短不同，使用的存储空间大小也不同。因此，找到更优秀的算法成了世界上最重要的课题之一。复旦算法协会就是由这些热爱算法与程序设计的人组成的社团。算法协会的活动内容丰富，社团成员不仅有机会深入学习算法的理论知识，还能通过实践来加强理解。社团鼓励成员参与国内外的算法竞赛，如ACM国际大学生程序设计竞赛等，以此来锻炼和检验自己的算法能力。',
        '19.jpg', '20.jpg');

-- ---------------------
-- Data for `quiz`
-- ---------------------

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (1, 'club', 1, '尤克里里社的slogan是什么？',
        '音乐的翅膀，携带梦想飞翔|披音乐星光，传弦歌魅力|弹奏快乐，传递音符|弦上跳动的不仅是音符，还有梦想',
        '披音乐星光，传弦歌魅力');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (2, 'club', 2, '钢琴协会的slogan是什么？',
        '以琴会友，以声寻梦，以乐传承|黑白键上，奏响友谊之歌|钢琴之声，心灵之交|音乐的桥梁，连接你我',
        '以琴会友，以声寻梦，以乐传承');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (3, 'club', 3, '国标舞协的slogan是什么？',
        '舞出青春，舞出自我|舞步中的诗，生命中的歌|To dance, to live, to be.|以舞会友，以舞传情',
        'To dance, to live, to be.');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (4, 'club', 4, '演讲与口才协会的slogan是什么？',
        '言为心声，语为桥梁|用声音传递力量，用话语触动心灵|演讲的舞台，思想的火花|宁鸣而死，不默而生', '宁鸣而死，不默而生');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (5, 'club', 5, '天文协会的slogan是什么？',
        '星辰大海，探索无限|漫天星辰愿作你最深沉的寄托|天文之美，科学之光|仰望星空，脚踏实地',
        '漫天星辰愿作你最深沉的寄托');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (6, 'club', 6, '复旦心脑学社的slogan是什么？',
        'Discover the mystery in your mind.|探索大脑，启迪智慧|心脑科学，探索未来|智慧的源泉，思想的火花',
        'Discover the mystery in your mind.');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (7, 'club', 7, '智能机器人创新社的slogan是什么？',
        '智能科技，创新未来|机器人，现实与梦想的桥梁|科技与浪漫的结合|机器人是科幻致于现实的浪漫',
        '机器人是科幻致于现实的浪漫');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (8, 'club', 8, '生态自然科考协会的slogan是什么？',
        '自然之美，科学之光|探索自然界的奥秘|与自然同行，探索生态奥秘|保护生态，探索自然', '探索自然界的奥秘');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (9, 'club', 9, '爱和猫协的slogan是什么？',
        '猫咪的守护者，校园的爱心使者|爱猫，爱生活，爱校园|科普爱猫知识，关注校园猫咪，爱和你在一起|关注流浪猫，传递爱与关怀',
        '科普爱猫知识，关注校园猫咪，爱和你在一起');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (10, 'club', 10, 'FudanACMICPC的slogan是什么？',
        '破题于弹指之间|编程挑战，智慧对决|算法之美，竞赛之魂|代码世界，解题高手', '破题于弹指之间');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (11, 'history', 1, '马相伯倾其家产创办的学院命名为？', '震旦学院|复旦公学|徐家汇学院|重庆学院', '震旦学院');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (12, 'history', 1, '复旦公学是在哪一年正式开学的？', '1902年|1905年|1911年|1917年', '1905年');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (13, 'history', 1, '1905年，于右任、邵力子等130名学生为什么愤然脱离震旦？',
        '学费问题|校址搬迁|为反抗教会势力干预校政|战争影响', '为反抗教会势力干预校政');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (14, 'history', 2, '在哪个时期，吴淞校舍为光复军司令部占用，导致复旦公学一度停办？',
        '辛亥革命|文化大革命|抗日战争|解放战争', '辛亥革命');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (15, 'history', 2, '复旦公学在1912年到1922年期间的校址是哪里？', '吴淞|徐家汇|江湾|重庆', '徐家汇');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (16, 'history', 2, '1912年到1922年，复旦公学在徐家汇的校舍是借用了哪里？',
        '李公祠|天文台|光复军司令部|南京临时政府', '李公祠');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (17, 'history', 3, '复旦大学在江湾奠基的时间是？', '1918年|1920年冬|1922年|1929年', '1920年冬');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (18, 'history', 3, '复旦大学在1929年根据什么法律进行改组？', '《教育法》|《大学法》|《大学组织法》|《民法典》',
        '《大学组织法》');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (19, 'history', 3, '复旦大学在改组后设立了几个学院，分别是什么？',
        '三个学院：文、理、法|四个学院：文、理、法、商|五个学院：文、理、法、商、工|六个学院：文、理、法、商、工、农',
        '四个学院：文、理、法、商');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (20, 'history', 4, '抗战爆发后，复旦大学的师生迁移至哪里？', '重庆北碚|上海徐汇|江湾|吴淞', '重庆北碚');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (21, 'history', 4, '复旦大学在重庆北碚建成的战时校园被称为什么？', '渝校|沪校|夏坝|江湾', '渝校');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (22, 'history', 4, '复旦大学（渝校）在1942年由私立改为什么性质的大学？', '私立|国立|公立|市立', '国立');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (23, 'history', 5, '复旦大学在1952年经历了哪一次重要的教育改革？',
        '教育私有化|全国高校院系调整|教育国有化|教育体制不变', '全国高校院系调整');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (24, 'history', 5, '复旦大学历史上的第一次腾飞是指什么事件？',
        '1949年上海解放|1952年全国高校院系调整|1959年被认定为全国十六所重点高校之一|复旦大学迁址',
        '1959年被认定为全国十六所重点高校之一');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (25, 'history', 5, '复旦大学被认定为全国重点高校后，其重点建设的学科基础是什么？', '理工科|文理|商科|医学',
        '文理');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (26, 'history', 6, '复旦大学在哪一年被确定为“七五”期间重点建设单位？', '1978年|1984年|1990年|1995年', '1984年');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (27, 'history', 6, '复旦大学历史上的第二次腾飞是指什么事件？',
        '1978年被国务院批准为全国重点高校|1984年被确定为“七五”期间重点建设单位|成为全国文理科综合性重点大学|跨入全国首批“211工程”高校建设行列',
        '跨入全国首批“211工程”高校建设行列');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (28, 'history', 6, '复旦大学在实现第二次腾飞后，成为哪种类型的重点大学？',
        '全国理工科综合性重点大学|全国文理科综合性重点大学|全国商科综合性重点大学|全国医科综合性重点大学',
        '全国文理科综合性重点大学');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (29, 'history', 7, '复旦大学与上海医科大学联合在哪一年组建成新的复旦大学？', '1995年|2000年|2005年|2010年',
        '2000年');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (30, 'history', 7, '2005年后，复旦大学校地扩展为哪几个校区？',
        '邯郸、江湾|邯郸、江湾、枫林|邯郸、江湾、枫林、张江|邯郸、江湾、枫林、徐汇、张江', '邯郸、江湾、枫林、张江');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (31, 'history', 7, '复旦大学在庆祝建校一百周年时，明确了什么样的发展目标？',
        '建设具有国内领先水平的综合性大学|建设具有世界一流水平的社会主义综合性大学|成为全国最大的高等教育机构|扩大国际合作与交流',
        '建设具有世界一流水平的社会主义综合性大学');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (35, 'history', 9, '1938年，复旦大学因何原因被迫踏上内迁之路？', '校园扩建|学生数量增加|抗日战争|经济原因',
        '抗日战争');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (36, 'history', 9, '复旦大学在抗日战争中最终在何处建校复课？', '上海江湾|重庆北碚夏坝|昆明白龙潭|重庆沙坪坝',
        '重庆北碚夏坝');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (37, 'history', 9, '复旦大学抗战内迁80周年时，学校通过何种方式纪念了这一历史性的迁徙？',
        '建立纪念碑|举办纪念讲座|出版《烽火中的复旦》一书|拍摄纪录片', '出版《烽火中的复旦》一书');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (38, 'history', 10, '复旦大学在1937年因何决定借用海格路附属实验中学继续办学？',
        '校园设施升级|抗日战争爆发|学校扩建|学生数量激增', '抗日战争爆发');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (39, 'history', 10, '复旦大夏联合大学的成立时间是哪一年？', '1937年|1938年|1939年|1940年', '1937年');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (40, 'history', 10, '复旦大夏联合大学解体后，复旦大学和大夏大学分别在何处继续办学？',
        '重庆和贵阳|上海和南京|北京和天津|广州和深圳', '重庆和贵阳');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (41, 'history', 11, '1938年2月，复旦大学迁移到北碚黄桷树镇后，得到了哪些方面的支持？',
        '政府资金支持|当地士绅和民众|国际援助|学生家长', '当地士绅和民众');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (42, 'history', 11, '复旦大学在北碚的新校区正式开学的时间是哪一年？', '1938年|1939年|1940年|1941年', '1939年');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (43, 'history', 11, '复旦大学在北碚黄桷树镇建立永久校址后，设立了什么奖项以帮助经济困难的学生？',
        '嘉陵纱厂纪念奖|复旦奖学金|士绅助学金|政府教育基金', '嘉陵纱厂纪念奖');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (44, 'history', 12, '复旦大学在抗日战争时期面临经济困难，是在哪一年改为国立大学？', '1940年|1941年|1942年|1943年',
        '1941年');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (45, 'history', 12, '复旦大学创始人马相伯逝世后，校友为纪念他发起了什么活动？',
        '建立图书馆|建立百龄堂|募捐活动|建立纪念碑', '募捐活动');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (46, 'history', 12, '章益在担任复旦大学校长期间，致力于提升哪方面？', '学校基础设施|教育质量|学生数量|国际交流',
        '教育质量');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (47, 'history', 13, '复旦大学在1940年成立了哪个学院？', '文学院|理学院|法学院|农学院', '农学院');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (48, 'history', 13, '复旦大学在战时特别注重学生哪方面能力的培养？', '理论知识|实践能力|外语水平|科研能力',
        '实践能力');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (49, 'history', 13, '复旦大学在战时师资力量的核心是什么？', '国际视野|学术成果|教学经验|坚守教育文化',
        '坚守教育文化');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (71, 'common', -1,
        '复旦大学创建于___年，原名复旦公学，是中国人自主创办的第一所高等院校，创始人为中国近代知名教育家___。',
        '1915年，李登辉|1915年，马相伯|1905年，马相伯|1905年，李登辉', '1905年，马相伯');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (72, 'common', -1,
        '复旦大学校名“复旦”二字选自《尚书大传虞夏传》中哪一句，意在自强不息，寄托当时中国知识分子自主办学、教育强国的希望？',
        '大学之道，在明明德|日月之行，若出其中|星汉灿烂，若出其里|日月光华，旦复旦兮', '日月光华，旦复旦兮');

INSERT INTO `quiz` (`id`, `topic`, `data_id`, `question`, `options`, `answer`)
VALUES (73, 'common', -1, '复旦大学校歌的词曲作者是？',
        '词：田汉，曲：丰子恺|词：刘大白，曲：聂耳|词：刘大白，曲：丰子恺|词：田汉，曲：聂耳', '词：刘大白，曲：丰子恺');


-- ---------------------
-- Data for `quiz_record`
-- ---------------------

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (1, 1, 1, '披音乐星光，传弦歌魅力', 1, '2024-05-04 12:25:30');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (2, 1, 2, '钢琴之声，心灵之交', 0, '2024-05-12 20:09:36');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (3, 1, 3, '舞步中的诗，生命中的歌', 0, '2024-05-12 21:15:43');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (4, 4, 37, '出版《烽火中的复旦》一书', 1, '2024-05-13 14:39:48');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (5, 4, 30, '邯郸、江湾、枫林、张江', 1, '2024-05-14 14:39:59');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (6, 4, 21, '渝校', 1, '2024-05-15 14:40:04');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (7, 4, 31, '建设具有世界一流水平的社会主义综合性大学', 1, '2024-05-16 14:40:12');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (8, 4, 15, '徐家汇', 1, '2024-05-17 14:40:16');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (9, 4, 45, '建立纪念碑', 0, '2024-05-17 14:40:23');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (10, 4, 3, 'To dance, to live, to be.', 1, '2024-05-17 14:40:30');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (11, 4, 30, '邯郸、江湾', 0, '2024-05-18 14:40:33');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (12, 4, 15, '吴淞', 0, '2024-05-19 14:41:57');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (13, 4, 3, '舞步中的诗，生命中的歌', 0, '2024-05-19 14:42:04');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (14, 4, 49, '坚守教育文化', 1, '2024-05-20 14:42:08');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (15, 4, 22, '国立', 1, '2024-05-20 14:42:17');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (16, 4, 7, '科技与浪漫的结合', 0, '2024-05-20 14:42:21');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (17, 4, 8, '探索自然界的奥秘', 1, '2024-05-20 14:42:25');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (18, 4, 15, '江湾', 0, '2024-05-20 14:42:30');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (19, 4, 5, '星辰大海，探索无限', 0, '2024-05-21 14:42:33');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (20, 4, 15, '重庆', 0, '2024-05-21 14:42:41');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (21, 4, 37, '出版《烽火中的复旦》一书', 1, '2024-05-21 14:42:52');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (22, 4, 73, '词：田汉，曲：丰子恺', 0, '2024-05-22 15:18:03');

INSERT INTO `quiz_record` (`id`, `user_id`, `quiz_id`, `answer`, `is_correct`, `create_timestamp`)
VALUES (23, 4, 71, '1905年，马相伯', 1, '2024-05-22 15:20:29');


-- ---------------------
-- Data for `recommend_link`
-- ---------------------

INSERT INTO `recommend_link` (`id`, `topic`, `title`, `link`)
VALUES (1, 'club', '开学在即！各美其美的复旦学生社团在等你！',
        'https://news.fudan.edu.cn/2021/0222/c1247a107999/page.htm');

INSERT INTO `recommend_link` (`id`, `topic`, `title`, `link`)
VALUES (2, 'club', '开学季 | 你身边的学术类社团，让你兴趣与学术两不误 ①',
        'https://news.fudan.edu.cn/2021/0926/c60a110110/page.htm');

INSERT INTO `recommend_link` (`id`, `topic`, `title`, `link`)
VALUES (3, 'club', '学术类社团大推荐，让你兴趣与学术两不误！②',
        'https://news.fudan.edu.cn/2021/1005/c60a110171/page.htm');

INSERT INTO `recommend_link` (`id`, `topic`, `title`, `link`)
VALUES (4, 'history', '辉煌校史 (fudan.edu.cn)',
        'https://www.fudan.edu.cn/449/list.htm');

INSERT INTO `recommend_link` (`id`, `topic`, `title`, `link`)
VALUES (5, 'history', '校史故事 (fudan.edu.cn)',
        'https://news.fudan.edu.cn/192/list.htm');

INSERT INTO `recommend_link` (`id`, `topic`, `title`, `link`)
VALUES (6, 'history', '复旦老建筑的前世今生，来了解一下吧！ (fudan.edu.cn)',
        'https://alumni.fudan.edu.cn/52/90/c29410a414352/page.htm');
-- ---------------------------------socket-service---------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------------------------------
SET FOREIGN_KEY_CHECKS = 1;
