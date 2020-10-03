using System;

namespace SimmleApp
{
    class Program
    {
        static void Main(string[] args)
        {

            /* 
              The Eastern calendar uses a 60-year cycle consisting of 12-year sub-cycles designated by
              color names: green, red, yellow, white, and black. 
              In each sub-cycle, the years are named after animals: rats, cows, tigers, hares, dragons, snakes, horses, sheep, monkeys, chickens, dogs, and pigs.
              Use the year number to determine its name, if 1984 is the beginning of the cycle: "year of the green rat".
            */

            string[] parentCycles = new string[] { "green", "red", "yellow", "white", "black" };
            string[] childCycles = new string[] { "rats", "cows", "tigers", "hares", "dragons", "snakes", "horses", "sheep", "monkeys", "chickens", "dogs", "pigs" };

            Console.Write("Write Year over the 1984: ");
            int year = Int32.Parse(Console.ReadLine());

            int initialYear = 1984;
            bool suitable = false;

            if (year > initialYear)
            {
                while (true)
                {
                    for (int i = 0; i < parentCycles.Length; i++)
                    {
                        for (int j = 0; j < childCycles.Length; j++)
                        {
                            if (year == initialYear)
                            {
                                Console.WriteLine($"Suitable year: {parentCycles[i]} {childCycles[j]}");
                                suitable = true;
                            }

                            initialYear += 1;
                        }
                    }

                    if (suitable)
                        break;
                }

                Console.WriteLine("Enter any keyboard to finish the program");
                Console.ReadKey();
            }



        }
    }
}
