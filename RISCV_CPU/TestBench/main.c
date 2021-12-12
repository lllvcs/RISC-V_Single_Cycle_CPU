void send(int data)
{
	int *uart_buffer_send=(int *)0x80000000;
	int *uart_control_send=(int *)0x80000004;
	*uart_buffer_send=data;
	*uart_control_send=1;
	while(*uart_control_send==1);
}
int receive()
{
	int *uart_buffer_receive=(int *)0x80000008;
	int *uart_control_receive=(int *)0x8000000c;
	while(*uart_control_receive==0);
	*uart_control_receive=0;
	return *uart_buffer_receive;
}

int main()  
{  
	for(int i=0;i<10;i++)
	{
		if(i<4)
		{
			send(i);
		}
		else if(i<7)
		{
			send(i*10+i);
		}
		else
		{
			send(i*111);
		}
	}

	while(1)
	{
		int data=receive();
		send(data);
	}
	return 0;
}