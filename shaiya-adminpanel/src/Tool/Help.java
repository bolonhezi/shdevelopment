/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Tool;

/**
 *
 * @author Jorgi Luiz Bolonhezi Dias
 */
 
public class Help extends javax.swing.JFrame {

    /**
     * Creates new form Help
     */
    public Help() {
        initComponents();
        setSize(750,309);
        setLocationRelativeTo(null);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jHelp = new javax.swing.JScrollPane();
        jTextArea1 = new javax.swing.JTextArea();
        jButton1 = new javax.swing.JButton();
        jFundo = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Help - Painel");
        setResizable(false);
        getContentPane().setLayout(null);

        jTextArea1.setColumns(20);
        jTextArea1.setRows(5);
        jTextArea1.setText("/apowercan - Works - Params CharName - Removes GM status of an account of person specified.\n/camlimit off - Works - No Params - Removes scroll limit on camera\n/camlimit on - Works - No Params - Adds scroll limit to camera\n/nera - Works - Params Type ID - Deletes NPC near you\n/nmake - Works - Params Type ID - Creates NPC\n/mera - Works - Params MobID Amount - Deletes mobs within 5-10 ft of you\n/mera t - Works - No Params - Deletes targeted mob\n/mmake - Works - Params MobID Amount - Creates up to 25 of the mob based off MoBID\n/getitem - Works - Params Type TypeID Amount - Creates am item based off ItemID\n/imake - Works - Params \"ItemName\" Amount - Creates items\n/set - Works - Params CharName Stat Amount - Sets stat you specify to amount up to 28671 for Stats, and greater for Kills/Deaths\n/kick - Works - Params CharName - kicks the character\n/event off - Works - Params \"CharName\" - Removes ALL buffs (Including Conts)\n/event on - Works - Params \"CharName\" - Seems to apply an \"Auto Cure\" effect\n/eclear - Works - Params CharName - Clears equipped items of self, or if specified player\n/iclear - Works - Params CharName - Clears inventory of self, or if specified player\n/cure - Works - Params CharName - Cures the player specified, or self if none is specified\n/auctionsearch - Works - Params CharName - Only works in AH, shows you Auctions (If any) of player\n/auctionrecall - Works - Params CharName MarketID - Only works in AH, DCs the player, and places the item in your Ended Auctions\n/bnotice - Works - Params \"Message\" - Unknown Usage currently\n/znotice - Works - Params \"Message\" - Notice to current map.\n/notice - Works - Params \"Message\" - Notice to all players. Normal notice.\n/wnotice - Works - Params CharName \"Message\" - \"Personal\" notice of sorts. Sends notice to 1 person only.\n/cnotice - Works - Params \"Message\" - Country Notice - Faction Notice\n/gmnotice - Params \"Message\" - Notice to GM accounts only\n/mob - Works - Params MobID - Basically useless\n/item - Works - Params ItemID - Basically useless\n/bsummon - works - Params CharName X Z Coordinates MapID - Summons the player you specify to the coordinates of the map you specify\n/asummon - works - Params CharName - Summons the specified player to you. Can fail if they're running, or in port\n/quiry - Works - Params CharName - Views stats and gear of player you specify\n/stopoff - Works - Params CharName - Removes move ban on the player you specify\n/stopon - Works - Params CharName - Bans movement on the player you specify\n/silence - Works - Params CharName - Bans chat on the player you specify\n/silence off - Works - Params CharName - Bans chat on the player you specify\n/watch - Works - Params CharName - Shows the location of the Character you specify\n/warning - Works - Params CharName \"Message\" - Sends the specified player the warning\n/fogend - Works - Params Unknown - Useless\n/fogstart - Works - Params Unknown - Useless\n/xcall - Works - Params 1/2 - Summons all of (1/Alliance | 2/Fury) to you. Current map only.\n/cmove - Works - Params MapID - Moves to the MapID specified\n/bmove - Works - Params X Z Coordinates MapID - Moves you to the coordinates on the map you specify\n/amove - Works - Params CharName - Moves you to the player specified\n/attack off - Works - No Params - Attack ability on\n/attack on - Works - No Params - Attack ability off\n/char off - Works - No Params - Invisibility off\n/char on - Works - No Params - Invisibility on\n/UQCOUNT - Works - Unknown how to control it or translate it\n/UQGET - Works - Unknown how to control it or translate it\n/basic - Works - No Params - Resets the below\n/point - Works - No Params - Shows everything as individual pixels\n/wire - Works - No Params - Shows the wire lining of objects\n__________________\n\nShaiya Server - GM Commands\n\nSome GM Commands.\n\nCharacter On/Off:\n/char on\n/char off\n\nAttack On/Off:\n/attack on\n/attack off\n\nSummon Player:\n/asummon <PlayerName>\n\nMove to Player:\n/amove <PlayerName>\n\nCountry Move:\n/cmove <MapID>\n\nGet Item:\n/getitem <ItemType> <ItemTypeID> <ItemCount>\n\nMonster Make:\n/mmake <MobID>\n\nMonster Erase Target:\n/mera t\n\nAnnouncement:\n/notice \"Some Message\"\n\nOllyDBG ASCII Dump of all commands:\n[SET_ZONE_0] Raigo\n[SET_ZONE_1] Light map1\n[SET_ZONE_2] Dark map1\n[SET_ZONE_3] D1 light portal\n[SET_ZONE_4] D1 Boss raum\n[SET_ZONE_5] Cornwell\n[SET_ZONE_6] Light Asmo room\n[SET_ZONE_7] Agrilla\n[SET_ZONE_8] Knight room\n[SET_ZONE_9] D2\n[SET_ZONE_10] D2\n[SET_ZONE_11] Kimu room\n[SET_ZONE_12] Cloron\n[SET_ZONE_13] Cloron\n[SET_ZONE_14] Cloron\n[SET_ZONE_15] FL\n[SET_ZONE_16] FL\n[SET_ZONE_17] FL\n[SET_ZONE_18] Proelium\n[SET_ZONE_19] Light map2\n[SET_ZONE_20] dark map2\n[SET_ZONE_21] Maitreyan\n[SET_ZONE_22] Maitreyan boss raum\n[SET_ZONE_23] AidionNekria\n[SET_ZONE_24] AidionNekria floor2\n[SET_ZONE_25] Elemental Cave\n[SET_ZONE_26] RuberChaos\n[SET_ZONE_27] ??????\n[SET_ZONE_28] Light map3\n[SET_ZONE_29] dark map3\n[SET_ZONE_30] CANTA\n[SET_ZONE_31] 20-30 dungeon light\n[SET_ZONE_32] 20-30 dungeon dark\n[SET_ZONE_33] Fedion Temple\n[SET_ZONE_34] Kalamus House\n[SET_ZONE_35] Apulune\n[SET_ZONE_36] Iris\n[SET_ZONE_37] Stigma\n[SET_ZONE_38] AZ\n[SET_ZONE_39] SECRET battle arena\n[SET_ZONE_40] Arena\n[SET_ZONE_41] SECRET Prison\n[SET_ZONE_42] Blackmarket\n[SET_ZONE_43] Pando\n[SET_ZONE_44] Lanhaar\n[SET_ZONE_45] DD2\n[SET_ZONE_46] DD2\n[SET_ZONE_47] Jungle\n[SET_ZONE_48] CT\n[SET_ZONE_49] CT\n[SET_ZONE_50] GRB Map\n[SET_ZONE_51] Light Guildhouse\n[SET_ZONE_52] Dark Guildhouse\n[SET_ZONE_53] Light Managment Office\n[SET_ZONE_54] Dark Managment Office\n[SET_ZONE_55] SkyCity\n[SET_ZONE_56] SkyCity\n[SET_ZONE_57] SkyCity\n[SET_ZONE_58] SkyCity\n[SET_ZONE_59] Fedion Temple\n[SET_ZONE_60] MAP LOAD ERROR (Elemental Cave2)\n[SET_ZONE_61] Stigma?\n[SET_ZONE_62] KH\n[SET_ZONE_63] AZ\n[SET_ZONE_64] Oblivian Island\n[SET_ZONE_65] MAP LOAD ERROR (Stable Erde)\n[SET_ZONE_66] MAP LOAD ERROR\n[SET_ZONE_66] MAP LOAD ERROR\n[SET_ZONE_67] MAP LOAD ERROR\n\n//\nMAP LOAD ERROR UP TO MAP 99\nif u /cmove to one of these maps ur toon is stuck and u get disconnect.\nno way u get out of that, as soon as u try to log in with the toon u\nget MAP LOAD ERROR again and a disconnect\n//\n\n[SET_ZONE_100] SECRET light managment office with mobs\n[SET_ZONE_101] SECRET dark managment office with mobs\n[SET_ZONE_102] PVP map 1-15 AZ no relics\n[SET_ZONE_103] Canta AZ mobs no relic\n[SET_ZONE_104] DWATER AZ mobs no relics\n[SET_ZONE_105] GODDESS BATTLE map 1-15 shiny stuff\n\nAny doubt just pm jorgebolonhezi at Skype.");
        jHelp.setViewportView(jTextArea1);

        getContentPane().add(jHelp);
        jHelp.setBounds(10, 10, 370, 260);

        jButton1.setBackground(new java.awt.Color(0, 51, 102));
        jButton1.setForeground(new java.awt.Color(255, 255, 255));
        jButton1.setText("Menu");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });
        getContentPane().add(jButton1);
        jButton1.setBounds(563, 243, 90, 30);

        jFundo.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Images/SY.jpg"))); // NOI18N
        getContentPane().add(jFundo);
        jFundo.setBounds(0, 0, 744, 282);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
            new JBLogin().setVisible(true);
            this.dispose();
            this.setResizable(false);
    }//GEN-LAST:event_jButton1ActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Help.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Help.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Help.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Help.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Help().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButton1;
    private javax.swing.JLabel jFundo;
    private javax.swing.JScrollPane jHelp;
    private javax.swing.JTextArea jTextArea1;
    // End of variables declaration//GEN-END:variables
}