import '../models/lib.dart';

final List<User> users = [
  User(
      name: const Name(first: 'Me', last: ''),
      avatarUrl: 'assets/avatar_1.png',
      lastActive: DateTime.now()),
  User(
      name: const Name(first: '老', last: '强'),
      avatarUrl: 'assets/avatar_2.png',
      lastActive: DateTime.now().subtract(const Duration(minutes: 10))),
  User(
      name: const Name(first: 'So', last: 'Duri'),
      avatarUrl: 'assets/avatar_3.png',
      lastActive: DateTime.now().subtract(const Duration(minutes: 20))),
  User(
      name: const Name(first: 'Lily', last: 'MacDonald'),
      avatarUrl: 'assets/avatar_4.png',
      lastActive: DateTime.now().subtract(const Duration(hours: 2))),
  User(
      name: const Name(first: 'Ziad', last: 'Aouad'),
      avatarUrl: 'assets/avatar_5.png',
      lastActive: DateTime.now().subtract(const Duration(hours: 6)))
];

final List<Email> emails = [
  Email(
    sender: users[1],
    recipients: [],
    subject: '豆花鱼',
    content: '最近忙吗？昨晚我去了你最爱的那家饭馆，点了他们的特色豆花鱼，吃着吃着就想你了。',
  ),
  Email(
    sender: users[2],
    recipients: [],
    subject: 'Dinner Club',
    content:
        "I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. Anyone else have other suggestions for dinner club this week? I'm so intrigued by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)\n\nSo",
  ),
  Email(
      sender: users[3],
      recipients: [],
      subject: 'This food show is made for you',
      content:
          "Ping– you'd love this new food show I started watching. It's produced by a Thai drummer who started getting recognized for the amazing vegan food she always brought to shows.",
      attachments: [const Attachment(url: 'assets/thumbnail_1.png')]),
  Email(
    sender: users[4],
    recipients: [],
    subject: 'Volunteer EMT with me?',
    content:
        'What do you think about training to be volunteer EMTs? We could do it together for moral support. Think about it??',
  ),
];

final List<Email> replies = [
  Email(
    sender: users[2],
    recipients: [
      users[3],
      users[2],
    ],
    subject: 'Dinner Club',
    content:
        "I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. Anyone else have other suggestions for dinner club this week? I'm so intrigued by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)\n\nSo",
  ),
  Email(
    sender: users[0],
    recipients: [
      users[3],
      users[2],
    ],
    subject: 'Dinner Club',
    content:
        "Yes! I forgot about that place! I'm definitely up for taking a risk this week and handing control over to this mysterious noodle chef. I wonder what happens if you have allergies though? Lucky none of us have any otherwise I'd be a bit concerned.\n\nThis is going to be great. See you all at the usual time?",
  ),
];
