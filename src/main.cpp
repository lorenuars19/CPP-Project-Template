#include "FortyTwo.hpp"

int main()
{
	FortyTwo de;
	FortyTwo ft("foo", 42);
	FortyTwo ft_1(ft);

	FortyTwo ft_2;

	ft_2 = ft_1;
	std::cout << "ft_2 name : " << ft_2.get_name() << '\n';
	ft_2.set_name("Copy");
	std::cout << "ft_2 name : " << ft_2.get_name() << '\n';

	ft.set_name("bar");
	de.set_name("baz");
	ft.set_num(43);
	de.set_num(19);

	std::cout << "name : " << ft.get_name() << " name : " << de.get_name() << std::endl;
	std::cout << "num : " << ft.get_num() << " num : " << de.get_num() << std::endl;

#if DEBUG == 1
	FortyTwo *leak = new FortyTwo;
	leak->set_var(-42);
#endif
	return 0;
}
