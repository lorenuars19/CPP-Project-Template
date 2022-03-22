#include "FortyTwo.hpp"

int	main()
{
	FortyTwo de;
	FortyTwo ft(42);
	FortyTwo ft_1(ft);

	FortyTwo ft_2 = ft;

	ft.setVar(19);
	de.setVar(10);

	return 0;
}
