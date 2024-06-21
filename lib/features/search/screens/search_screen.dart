import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color.fromARGB(255, 7, 12, 29);
    const Color searchBarColor = Color.fromARGB(255, 13, 24, 61);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 194, 194, 194),
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 40,
            ),
            const SizedBox(width: 10),
            const Text(
              'Dustin',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
      ),
      body: Container(
        color: backgroundColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  filled: true,
                  fillColor: searchBarColor,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Transform.rotate(
                      angle: -40 *
                          (3.1415926535897932 /
                              180), // Convert 45 degrees to radians
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
                    onPressed: () {
                      // Handle search action
                    },
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 217, 217, 217)
                          .withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Text(
                      'Lorem ipsum, dolor sit amet consectetur adipisicing elit. '
                      'Porro facilis perferendis commodi rem corrupti beatae '
                      'voluptas illo exercitationem? A perspiciatis harum fuga '
                      'maxime delectus dolores ratione enim repudiandae, doloribus '
                      'quae! In quod corporis, enim, distinctio et voluptates '
                      'numquam labore amet dolorum explicabo cumque iusto ullam '
                      'laudantium. Incidunt nobis magni rem tenetur, beatae '
                      'repellat laboriosam accusantium assumenda, optio reiciendis '
                      'ipsam dignissimos. Quae a enim obcaecati, sunt possimus '
                      'minima earum explicabo minus molestias dicta? Quas '
                      'consequuntur fugit, perspiciatis vitae, aperiam eum ratione '
                      'pariatur quia, inventore repellat perferendis ipsa voluptatum '
                      'nihil doloremque atque! Facere iure maiores assumenda '
                      'repellendus dolores dicta illum quae, laborum dolorum '
                      'obcaecati suscipit perspiciatis officia exercitationem? '
                      'Atque modi quae amet consectetur rerum qui, dolore, '
                      'molestiae commodi recusandae ipsum totam ut!',
                      style: TextStyle(color: Color.fromARGB(255, 255,254,254)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: backgroundColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
