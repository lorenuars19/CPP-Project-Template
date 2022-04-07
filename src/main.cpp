#include "FortyTwo.hpp"

int	main()
{
	FortyTwo de;
	FortyTwo ft(42);
	FortyTwo ft_1(ft);

	FortyTwo ft_2 = ft;

	ft.set_var(19);
	de.set_var(10);

#if DEBUG == 1
	FortyTwo* leak =  new FortyTwo;
	leak->set_var(-42);
#endif
	return 0;
}
