void Heavy() 
{
  var sw = DateTime.Now;
  Console.WriteLine("= " + sw);

  long sum = 0;

  try
  {
    for (int k = 1; k < 20; ++k)
    {
      for (int i = 1; i < int.MaxValue / 32; ++i)
      {
        sum ^= k;
        sum *= i; 
      }
      Console.WriteLine(k + "  " + (DateTime.Now - sw).TotalSeconds);
    }
  }
  catch (Exception e)
  {
    Console.Error.WriteLine(e);
  }
  finally
  {
    Console.Error.WriteLine("*");
  }

  Console.WriteLine(sum);
}

void Call(Action action)
{
  action();
}

Call(Heavy);
