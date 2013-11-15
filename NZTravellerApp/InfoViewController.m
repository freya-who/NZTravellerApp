//
//  InfoViewController.m
//  Aotearoa
//
//  Created by Frederike Schmitz on 14.11.13.
//  Copyright (c) 2013 Frederike Schmitz. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.infoText.text = @"Liebe Eltern,\n\num euch die Koordination zwischen Google Earth und den Bildern zu erleichtern, habe ich euch diese App gemacht. Die Sterne auf der App stellen einige interessante Punkte in Neuseeland dar, mit ein wenig Information zum Ort, ein paar Fotos (die meisten von mir selbst gemacht), einer Bewertung (von 1 - 5 Sternen) und tatsächlichen GPS Koordinaten, die ihr euch rauskopieren und in euer Navi eingeben könnt.\n\nEs sei zu sagen, dass die Positionen der Sterne auf der Karte nicht exakt ist, die Koordinaten in der Info allerdings meistens schon. Außerdem ist eine Wertung von 1 Stern nicht schlecht, sonst wäre der Punkt gar nicht auf der Karte.\n\nAuch sind auf dieser Karte nicht alle schönen Stellen vermerkt. Bei einigen konnte ich mich nicht mehr erinnern, wo sie waren, andere habe ich einfach vergessen und trotz meines langen Aufenthaltes habe ich auch vieles einfach nicht gesehen. Also: geht auch selbst auf Erkundungstour! Wenn irgendeine Abzweigung auf der Straße schön aussieht, einfach langfahren! Ihr habt ja auch zusätzlich noch einen Reiseführer, den ihr befragen könnt, und ganz wichtig: andere Reisende! Scheut euch nicht, auch einfach Leute auf Englisch anzuquatschen, in Neuseeland kann man davon ausgehen, dass die Person super nett, freundlich und hilfreich sein wird. Und euer Englisch ist besser als ihr denkt, die meisten Kiwis sind überrascht, wie gut Ausländer Englisch sprechen können, und das sagten sie damals auch bei einigen Backpackern, die definitiv schlechter Englisch gesprochen haben als ihr! Eine weitere gute Anlaufstelle sind die mit i gekennzeichneten Touristeninformationen, die es in jedem Ort gibt. Dort gibt es kostenlose Auskünfte und sehr gut Beratung.\n\nZu den Städten selbst (Auckland, Wellington, Christchurch, …) habe ich keine Informationen in die App gepackt, da man die am besten selbst nach eigenen Vorlieben erkundet. Ich kann euch aber raten, nicht allzu viel Zeit in den Städten zu verbringen, die Natur ist sehr viel schöner! Eine Ausnahme bildet vielleicht das Te Papa Museum in Wellington, das fand selbst ich als Museumsmuffel einen Besuch wert. Vielleicht, wenn das Wetter mal nicht so gut ist und ihr trotzdem was unternehmen wollt.\n\nIch wünsche euch eine ganz, ganz tolle Zeit, genießt die 4 Wochen und traut euch auch, neues auszuprobieren. Sammelt tolle Erinnerungen (und Fotos!), bleibt auf der linken Seite der Straße und denkt beim links abbiegen daran, dass der entgegenkommende Verkehr (der von seiner Seite aus rechts abbiegt) Vorfahrt hat!\n\nIch habe euch lieb!\n\nFrederike";
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
