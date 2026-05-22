library IEEE;                                   
use IEEE.STD_LOGIC_1164.ALL;                    

entity TFF is                                   
    Port ( T     : in  STD_LOGIC;                -- for Toggle
           CLK   : in  STD_LOGIC;                
           RESET : in  STD_LOGIC;                -- ورودی ریست برای صفر کردن خروجی
           Q     : out STD_LOGIC);               
end TFF;                                        

architecture Behavioral of TFF is                
    signal Q_int : STD_LOGIC := '0';             -- سیگنال داخلی برای نگهداری مقدار فعلی خروجی
begin                                  
    process(CLK, RESET)                          -- بلوک پردازش حساس به تغییرات کلاک و ریست
    begin                             
        if RESET = '1' then                      
            Q_int <= '0';                       
        elsif rising_edge(CLK) then             
            if T = '1' then                      
                Q_int <= not Q_int;              
            end if;                             
        end if;                                  
    end process;                                

    Q <= Q_int;                                  -- انتساب مقدار سیگنال داخلی به پورت خروجی اصلی
end Behavioral;                                 
--------------------------------------------------------------------------------
library IEEE;                                    
use IEEE.STD_LOGIC_1164.ALL;                    
use IEEE.NUMERIC_STD.ALL;                        

entity Counter_Nbit is                          
    Generic (                                    
        N            : integer := 8;             
        COUNTER_TYPE : string  := "NMOD";        -- نوع شمارنده ("UP" یا "DOWN" یا "UPDOWN" یا "NMOD")
        MOD_VALUE    : integer := 4             
    );
    Port ( CLK     : in  STD_LOGIC;             
           RESET   : in  STD_LOGIC;            
           ENABLE  : in  STD_LOGIC;            
           UP_DOWN : in  STD_LOGIC;              -- ورودی تعیین جهت (1=بالاشمار، 0=پایین‌شمار) در حالت UPDOWN
           Q       : out STD_LOGIC_VECTOR(N-1 downto 0) 
         );
end Counter_Nbit;                               

architecture Structural of Counter_Nbit is      

    component TFF                                
        Port(T, CLK, RESET : in STD_LOGIC;      
             Q : out STD_LOGIC);                 
    end component;                               

    signal counter_value : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0'); 
    signal toggle_signal : STD_LOGIC_VECTOR(N-1 downto 0);                   
    signal count_up      : STD_LOGIC;                                       
    
    signal nmod_reached  : std_logic;                                        

begin                                          

    count_up <= '0' when COUNTER_TYPE = "DOWN" else    
                UP_DOWN when COUNTER_TYPE = "UPDOWN" else 
                '1';                                     

    Q <= counter_value;

    nmod_reached <= '1' when (COUNTER_TYPE = "NMOD" and unsigned(counter_value) = MOD_VALUE - 1) else '0';
          
    process(ENABLE, counter_value, count_up, nmod_reached)
        variable all_ones  : STD_LOGIC;       
        variable all_zeros : STD_LOGIC;       
    begin                                     
        
        if ENABLE = '0' then                    
            toggle_signal(0) <= '0';           
        elsif nmod_reached = '1' then          
            toggle_signal(0) <= counter_value(0);
        else                                   
            toggle_signal(0) <= '1';           
        end if;                                 

        for i in 1 to N-1 loop                 
            all_ones  := '1';                   
            all_zeros := '1';                  
            
            for j in 0 to i-1 loop            
                all_ones  := all_ones and counter_value(j);          
                all_zeros := all_zeros and (not counter_value(j));   
            end loop;                          
            
            if ENABLE = '0' then               
                toggle_signal(i) <= '0';        
            elsif nmod_reached = '1' then       
                toggle_signal(i) <= counter_value(i); 
            else                               
                if count_up = '1' then         
                    toggle_signal(i) <= all_ones;
                else                        
                    toggle_signal(i) <= all_zeros;
                end if;                        
            end if;                            
        end loop;                               
    end process;                             
   

    gen_flipflops: for i in 0 to N-1 generate    
        FF: TFF port map(                       
            T     => toggle_signal(i),         
            CLK   => CLK,                        
            RESET => RESET,                
            Q     => counter_value(i)          
        );
    end generate;                           

end Structural;                                
