import 'package:flutter/material.dart';
import 'class_group.dart';

const Color themeColor = Color.fromRGBO(71, 46, 219, 0.7);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mild Task',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: themeColor)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _emailController;
  late TextEditingController _passController;

  void loginAction() {
    var email = _emailController.text;
    var pass = _passController.text;

    print('Email: $email ; Password: $pass');

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(children: [
            Container(
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill)),
                child: Stack(children: [
                  PositionedImage(
                    height: 200,
                    width: 80,
                    left: 30,
                    imagePath: 'assets/images/light-1.png',
                  ),
                  PositionedImage(
                    height: 140,
                    width: 80,
                    left: 180,
                    imagePath: 'assets/images/light-2.png',
                  ),
                  Positioned(
                    height: 58,
                    width: 58,
                    right: 40,
                    top: 40,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/clock.png'))),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ])),
            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(99, 105, 216, 0.3),
                            blurRadius: 20.0,
                            offset: Offset(0, 10),
                          ),
                        ]),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey))),
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email Or Phone Number',
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            controller: _passController,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(99, 105, 216, 1),
                          Color.fromRGBO(99, 105, 216, 0.6)
                        ])),
                    child: Expanded(
                        child: TextButton(
                      style: ButtonStyle(),
                      onPressed: () {
                        loginAction();
                      },
                      child: Text('Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    )),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Color.fromRGBO(99, 105, 216, 1)),
                    ),
                  )
                ],
              ),
            )
          ]),
        ));
  }
}

class PositionedImage extends StatelessWidget {
  const PositionedImage(
      {super.key,
      required this.height,
      required this.width,
      required this.left,
      required this.imagePath});

  final double height;
  final double width;
  final double left;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: height,
      width: width,
      left: left,
      child: Container(
        decoration:
            BoxDecoration(image: DecorationImage(image: AssetImage(imagePath))),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final double outerContainerRadius = 20.0;
  final Color backgroundColor = Color.fromRGBO(206, 205, 212, 1);
  final Color navBarIconColor = Color.fromRGBO(71, 46, 219, 0.7);

  var pageIndex = 0; //On start opens to current page

  @override
  Widget build(BuildContext context) {
    const double innerBoxPadding =
        10; //Size of the inner raised box from the edge of the screen

    Widget page; //Controls which page the mainArea is set to
    switch (pageIndex) {
      case 0: //Current Page
        page = CurrentsPage();
        break;

      case 1: //Explore Page
        page = ExplorePage();
        break;

      case 2: //Profile Management Page
        page = ProfilePage();
        break;

      default:
        throw UnimplementedError('No Widget for $pageIndex');
    }

    var mainArea = AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: page,
    );

    return Scaffold(
        backgroundColor: backgroundColor,
        body: LayoutBuilder(builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(innerBoxPadding),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(outerContainerRadius),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.6), blurRadius: 7.5)
                ],
              ),
              child: Column(
                children: [
                  Expanded(child: mainArea),
                  SafeArea(
                      child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(outerContainerRadius),
                        bottomRight: Radius.circular(outerContainerRadius)),
                    child: BottomNavigationBar(
                      items: [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.contacts_rounded),
                          label: 'Current',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.explore),
                          label: 'Explore',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.person),
                          label: 'Profile',
                        ),
                      ],
                      currentIndex: pageIndex,
                      onTap: (value) {
                        setState(
                          () {
                            pageIndex = value;
                          },
                        );
                      },
                    ),
                  ))
                ],
              ),
            ),
          );
        }));
  }
}

class CurrentsPage extends StatelessWidget {
  final TextStyle helloStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  final TextStyle nameStyle = TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(71, 46, 219, 0.7));

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              top: 20,
            ),
            child: Text('Hello,', style: helloStyle),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Marcus',
              style: nameStyle,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 20,
            top: 8,
            left: 20,
            right: 20,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
        Expanded(
          child: GroupListView2(),
        )
      ],
    );
  }
}

class GroupListView2 extends StatelessWidget {
  GroupListView2({
    super.key,
  });

  static final List<Group> groups = [
    Group('Trivia Night', 'Central Social Hall', 6, 'Thurs', 11, '7:00 PM'),
    Group('Badminton', 'Macewan University', 8, 'Sat', 4, '12:00 PM'),
    Group('House Party', 'Edmonton', 12, 'Tues', 15, '9:00 PM'),
    Group('Rock Climbing', 'University Of Alberta', 25, 'Thurs', 6, '4:00 PM'),
    Group('Trivia Night', 'Central Social Hall', 6, 'Thurs', 11, '7:00 PM'),
    Group('Badminton', 'Macewan University', 8, 'Sat', 4, '12:00 PM'),
    Group('House Party', 'Edmonton', 12, 'Tues', 15, '9:00 PM'),
    Group('Rock Climbing', 'University Of Alberta', 25, 'Thurs', 6, '4:00 PM'),
  ];

  static final List<Person> people = [
    Person("Stacy"),
    Person("Kyle"),
    Person("George"),
    Person("Ricky Spanish"),
    Person("Stacy"),
    Person("Kyle"),
    Person("George"),
    Person("Ricky Spanish"),
  ];

  final List<GroupChat> groupChats = [
    GroupChat(groups[0], people),
    GroupChat(groups[1], people),
    GroupChat(groups[2], people),
    GroupChat(groups[3], people),
    GroupChat(groups[4], people),
    GroupChat(groups[5], people),
    GroupChat(groups[6], people),
    GroupChat(groups[7], people),
  ];

  static const Gradient _maskingGradient2 = LinearGradient(
    //Used for blurring
    colors: [Colors.transparent, Colors.black],
    stops: [0.0, 0.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    if (groupChats.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'You Are Not Currently Part of Any Events',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/reading.png'))),
            )
          ],
        ),
      );
    } else {
      return ShaderMask(
        shaderCallback: (bounds) => _maskingGradient2.createShader(bounds),
        blendMode: BlendMode.dstIn,
        child: AnimatedList(
          // reverse: true, //Starts the list of events from the bottom
          initialItemCount: groupChats.length,
          itemBuilder: (context, index, animation) {
            final GroupChat chat = groupChats[index];
            return SizeTransition(
              sizeFactor: animation,
              child: GroupChatTile(chat: chat, index: index),
            );
          },
        ),
      );
    }
  }
}

class GroupChatTile extends StatelessWidget {
  GroupChatTile({
    super.key,
    required this.chat,
    required this.index,
  });

  final GroupChat chat;
  final int index;

  @override
  Widget build(BuildContext context) {
    final people = chat.attendees;
    final event = chat.event;
    final personName = people[index].name;

    const double picSize = 60;

    final TextStyle nameStyle = TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);

    final TextStyle messageStyle =
        TextStyle(fontSize: 15, color: Colors.grey.withOpacity(0.75));

    final TextStyle timeStyle = TextStyle(fontSize: 12, color: Colors.black);

    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(
          left: 20.0,
        ),
        //Wrapped with container to allow use of expanded
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                //Group Chat Image
                height: picSize,
                width: picSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/profile_pic.png')),
                  borderRadius: BorderRadius.circular(90),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: nameStyle,
                      ),
                      SizedBox(height: 10),
                      Text(
                        '$personName: Message...',
                        style: messageStyle,
                      )
                    ],
                  )),
              Container(
                height: picSize + 20,
                padding: EdgeInsets.only(
                  top: 15,
                ),
                child: Align(
                  //For Showing the time of last message in top right corner
                  alignment: Alignment.topRight,
                  child: Text(event.time, style: timeStyle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}

class GroupListView extends StatelessWidget {
  GroupListView({
    super.key,
  });

  static const Gradient _maskingGradient = LinearGradient(
    //Used for blurring
    colors: [Colors.transparent, Colors.black],
    stops: [0.0, 0.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  final List<Group> groups = [
    Group('Trivia Night', 'Central Social Hall', 6, 'Thurs', 11, '7:00'),
    Group('Badminton', 'Macewan University', 8, 'Sat', 4, '12:00'),
    Group('House Party', 'Edmonton', 12, 'Tues', 15, '9:00'),
    Group('Rock Climbing', 'University Of Alberta', 25, 'Thurs', 6, '4:00'),
    Group('Trivia Night', 'Central Social Hall', 6, 'Thurs', 11, '7:00'),
    Group('Badminton', 'Macewan University', 8, 'Sat', 4, '12:00'),
    Group('House Party', 'Edmonton', 12, 'Tues', 15, '9:00'),
    Group('Rock Climbing', 'University Of Alberta', 25, 'Thurs', 6, '4:00'),
    Group('Trivia Night', 'Central Social Hall', 6, 'Thurs', 11, '7:00'),
    Group('Badminton', 'Macewan University', 8, 'Sat', 4, '12:00'),
    Group('House Party', 'Edmonton', 12, 'Tues', 15, '9:00'),
    Group('Rock Climbing', 'University Of Alberta', 25, 'Thurs', 6, '4:00'),
    Group('Trivia Night', 'Central Social Hall', 6, 'Thurs', 11, '7:00'),
    Group('Badminton', 'Macewan University', 8, 'Sat', 4, '12:00'),
    Group('House Party', 'Edmonton', 12, 'Tues', 15, '9:00'),
    Group('Rock Climbing', 'University Of Alberta', 25, 'Thurs', 6, '4:00'),
  ];

  final List<Color> colorRotations = [
    Color.fromRGBO(158, 46, 219, 1),
    Color.fromRGBO(46, 107, 219, 1),
    Color.fromRGBO(71, 46, 219, 1),
  ];

  var colorIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (groups.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'You Are Not Currently Part of Any Events',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/reading.png'))),
            )
          ],
        ),
      );
    } else {
      return ShaderMask(
        shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
        blendMode: BlendMode.dstIn,
        child: AnimatedList(
          reverse: true, //Starts the list of events from the bottom
          initialItemCount: groups.length,
          itemBuilder: (context, index, animation) {
            final group = groups[index];
            final color = colorRotations[colorIndex];
            colorIndex += 1;
            colorIndex %= 3;
            return SizeTransition(
              sizeFactor: animation,
              child: EventTile(group: group, color: color),
            );
          },
        ),
      );
    }
  }
}

class EventTile extends StatelessWidget {
  const EventTile({
    super.key,
    required this.group,
    required this.color,
  });

  final Group group;
  final Color color;

  @override
  Widget build(BuildContext context) {
    //Formatting the text
    var numDate = group
        .date; //Done since accessing group members messes with string interpolation
    String date;
    if (numDate < 10) {
      date = '0$numDate';
    } else {
      date = '$numDate';
    }

    return Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 30,
        right: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(Icons.radio_button_checked),
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  date,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
                Text(
                  group.day,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: color,
                  boxShadow: [
                    BoxShadow(
                        color: color.withOpacity(0.5),
                        blurRadius: 1,
                        offset: Offset(-5, 5))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    group.time,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const double outerContainerRadius = 20;
    const double profilePicSize = 150; //Profile pic is 'square'
    const double profilePicDistance = 30; //Distaance of profile pic from sides

    const TextStyle nameStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
    );

    const TextStyle buttonStyle = TextStyle();

    final List<String> tags = [
      'Rock Climbing',
      'Trivia',
      'Badminton',
      'House Partying',
    ];

    return Container(
      padding: const EdgeInsets.only(
        top: profilePicDistance,
        left: 8,
        right: 8,
        bottom: profilePicDistance,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(outerContainerRadius)),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: profilePicDistance), //Spacing
              Container(
                //Profile Picture
                height: profilePicSize,
                width: profilePicSize,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: themeColor),
                  image: DecorationImage(
                      image: AssetImage('assets/images/profile_pic.png')),
                  borderRadius: BorderRadius.circular(profilePicSize),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    //Profile Name
                    Text("Jessica Taylor", style: nameStyle),
                    Container(
                      //Tags Animated List
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      width: double.infinity,
                      height: 30,
                      child: TagsListView(
                        tags: tags,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 10), //Spacing
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (states) {
                        if (states.contains(MaterialState.pressed)) {
                          return themeColor.withOpacity(0.2);
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  label: Text(
                    'Edit Profile',
                    style: buttonStyle,
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                ),
                TextButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (states) {
                        if (states.contains(MaterialState.pressed)) {
                          return themeColor.withOpacity(0.2);
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  label: Text(
                    'Share Profile',
                    style: buttonStyle,
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.person_add_alt_outlined),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey.withOpacity(0.7),
                ),
              ),
              child: Text("Bio: ..."),
            ),
          ),
          Expanded(
            flex: 2,
            child: PicturesListView(),
          )
        ],
      ),
    );
  }
}

class PicturesListView extends StatelessWidget {
  PicturesListView({
    super.key,
  });

  static const int numPictures = 5;
  final int index = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: numPictures,
        itemBuilder: (context, index) {
          index = (index + 1) % 2;
          return PictureListViewItem(
            index: index,
          );
        });
  }
}

class PictureListViewItem extends StatelessWidget {
  const PictureListViewItem({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.camera_alt_rounded, size: 150),
          SizedBox(width: 15),
          Icon(Icons.camera_alt_rounded, size: 150),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.camera_alt_outlined, size: 150),
          SizedBox(width: 15),
          Icon(Icons.camera_alt_outlined, size: 150),
        ],
      );
    }
  }
}

class TagsListView extends StatelessWidget {
  TagsListView({
    super.key,
    required this.tags,
  });

  final List<String> tags;

  static const Gradient _maskingGradient = LinearGradient(
    colors: [Colors.transparent, Colors.grey],
    stops: [0.0, 0.1],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
      // This blend mode takes the opacity of the shader (i.e. our gradient)
      // and applies it to the destination (i.e. our animated list).
      blendMode: BlendMode.dstIn,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        itemBuilder: (context, index) {
          final String tag = tags[index];
          return TagContainer(tag: tag);
        },
      ),
    );
  }
}

class TagContainer extends StatelessWidget {
  const TagContainer({
    super.key,
    required this.tag,
  });

  final String tag;
  static const TextStyle tagStyle = TextStyle(
    fontSize: 14,
    fontStyle: FontStyle.italic,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 5),
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(tag, style: tagStyle),
      ),
    );
  }
}
