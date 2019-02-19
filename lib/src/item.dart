class Item {
  final String name;
  final String description;
  final bool liked;

  const Item({ this.name, this.description, this.liked });
}

final items = [
  new Item(name: 'Blah-blah', description: 'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Omnis, obcaecati?', liked: false),
  new Item(name: 'Lorem, ipsum.', description: 'Lorem ipsum dolor sit amet consectetur.', liked: true),
  new Item(name: 'Ipsum', description: 'Lorem ipsum dolor sit amet consectetur adipisicing elit.', liked: false),
  new Item(name: 'Spain', description: 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Error, labore vero?', liked: false),
  new Item(name: 'Specific', description: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Praesentium quae eveniet in nemo.', liked: true),
];
