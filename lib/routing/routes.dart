const rootRoute = "/";

const overviewPageDisplayName = "Overview";
const overviewPageRoute = "/overview";

const residentsPageDisplayName = "Residents";
const residentsPageRoute = "/residents";

const propertiesPageDisplayName = "Properties";
const propertiesPageRoute = "/properties";

const staffsPageDisplayName = "Staffs";
const staffsPageRoute = "/staffs";

const chatsPageDisplayName = "Chats";
const chatsPageRoute = "/chats";

const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItemRoutes = [
  MenuItem(overviewPageDisplayName, overviewPageRoute),
  MenuItem(residentsPageDisplayName, residentsPageRoute),
  MenuItem(propertiesPageDisplayName, propertiesPageRoute),
  MenuItem(staffsPageDisplayName, staffsPageRoute),
  MenuItem(chatsPageDisplayName, chatsPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
